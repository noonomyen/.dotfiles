local DisplayManager = {}
DisplayManager.__index = DisplayManager

--- Installs an early hook on `hl.monitor` to intercept and discard Caelestia's
--- hardcoded default rule: `hl.monitor({ output = "", mode = "preferred" })`.
--- This prevents the laptop display from momentarily waking up during config reloads.
function DisplayManager.install_hook()
    if hl and hl.monitor and not _G.__original_hl_monitor then
        _G.__original_hl_monitor = hl.monitor
        hl.monitor = function(args)
            if type(args) == "table" and (args.output == "" or args.output == nil) then
                return
            end
            return _G.__original_hl_monitor(args)
        end
    end
end

-- Read EDID to extract monitor model name or hex product code (e.g. "ARZOPA-27" or "0x004D")
local function parse_edid(edid_path)
    local f = io.open(edid_path, "rb")
    if not f then return nil, nil end
    local data = f:read(128)
    f:close()
    if not data or #data < 128 then return nil, nil end

    -- Verify standard EDID header: 00 FF FF FF FF FF FF 00
    if data:sub(1, 8) ~= "\0\255\255\255\255\255\255\0" then
        return nil, nil
    end

    -- Extract ASCII model name from descriptor blocks (1-indexed block + 6 to block + 18)
    local model_name = nil
    for block = 54, 108, 18 do
        if data:byte(block + 1) == 0 and data:byte(block + 2) == 0 and data:byte(block + 4) == 0xfc then
            local str = data:sub(block + 6, block + 18)
            model_name = str:gsub("[\r\n%z]", ""):gsub("^%s*(.-)%s*$", "%1")
            break
        end
    end

    -- Extract product code (hex string like "0x004D")
    local prod_code = data:byte(11) | (data:byte(12) << 8)
    local prod_hex = string.format("0x%04X", prod_code)

    return model_name, prod_hex
end

-- Fetch all physically connected monitors on primary GPU
local function get_physical_monitors()
    local monitors = {}
    local connectors = { "eDP-1", "HDMI-A-1", "DP-1", "HDMI-A-2" }
    local card_prefix = "/sys/class/drm/card1-"

    for _, conn in ipairs(connectors) do
        local path = card_prefix .. conn
        local status_f = io.open(path .. "/status", "r")
        if status_f then
            local status = status_f:read("*l")
            status_f:close()

            if status == "connected" then
                local model_name, prod_hex = parse_edid(path .. "/edid")
                table.insert(monitors, {
                    name = conn,
                    model = model_name or prod_hex,
                    prod_hex = prod_hex,
                    description = model_name or prod_hex,
                })
            end
        end
    end

    -- Fallback to hl.get_monitors() if sysfs probe returned empty
    if #monitors == 0 and hl and hl.get_monitors then
        return hl.get_monitors()
    end

    return monitors
end

-- Check if a monitor matches all criteria in spec
local function matches_spec(mon, spec)
    for k, v in pairs(spec) do
        local matched = false
        local val = mon[k]

        if k == "model" then
            if val == v or (val and tostring(val):find(tostring(v), 1, true)) then
                matched = true
            elseif mon.prod_hex and mon.prod_hex == tostring(v) then
                matched = true
            elseif mon.description and tostring(mon.description):find(tostring(v), 1, true) then
                matched = true
            end
        else
            if val ~= nil and (val == v or tostring(val):find(tostring(v), 1, true)) then
                matched = true
            end
        end

        if not matched then
            return false
        end
    end
    return true
end

-- Generate canonical signature for monitor list to detect hotplug changes
local function compute_monitors_signature(monitors)
    local parts = {}
    for i, m in ipairs(monitors) do
        parts[i] = string.format("%s:%s", tostring(m.name), tostring(m.model or ""))
    end
    table.sort(parts)
    return table.concat(parts, "|")
end

function DisplayManager:notify(msg, is_error)
    local prefix = "[DisplayManager] "
    io.stderr:write(prefix .. msg .. "\n")

    local urgency = is_error and "critical" or "normal"
    local timeout = is_error and 5000 or 2500
    local icon = is_error and "dialog-error" or "video-display"
    local safe_msg = "'" .. msg:gsub("'", "'\\''") .. "'"
    local cmd = string.format("notify-send -a 'Display Manager' -i %s -u %s -t %d 'Display Manager' %s &", icon, urgency, timeout, safe_msg)
    os.execute(cmd)
end

function DisplayManager.new()
    local self = setmetatable({}, DisplayManager)
    self.profiles = {}
    self.fallback = nil

    _G.__display_manager_state = _G.__display_manager_state or {
        active_profile_name = nil,
        last_monitors_sig   = nil,
        last_eval_time      = 0,
        listener_registered = false,
        active_instance     = nil,
    }

    self.state = _G.__display_manager_state
    self.state.active_instance = self

    return self
end

function DisplayManager:add_profile(profile)
    assert(type(profile) == "table", "Profile must be a table")
    assert(type(profile.match) == "table", "Profile 'match' must be a table")
    assert(type(profile.apply) == "function", "Profile 'apply' must be a function")

    local match_count = 0
    for _ in pairs(profile.match) do
        match_count = match_count + 1
    end
    profile._match_count = match_count

    table.insert(self.profiles, profile)
    return self
end

function DisplayManager:set_fallback(fn)
    assert(type(fn) == "function", "Fallback must be a function")
    self.fallback = fn
    return self
end

local function try_bind_profile(monitors, profile)
    if #monitors ~= profile._match_count then
        return nil
    end

    local bound = {}
    local used = {}

    for id, spec in pairs(profile.match) do
        local found_idx = nil
        for idx, mon in ipairs(monitors) do
            if not used[idx] and matches_spec(mon, spec) then
                found_idx = idx
                break
            end
        end

        if not found_idx then
            return nil
        end

        used[found_idx] = true
        bound[id] = monitors[found_idx]
    end

    return bound
end

function DisplayManager:evaluate(force)
    local monitors = get_physical_monitors()
    if #monitors == 0 then
        return false
    end

    local monitors_sig = compute_monitors_signature(monitors)
    local target_profile = nil
    local bound_monitors = nil

    for _, prof in ipairs(self.profiles) do
        local bound = try_bind_profile(monitors, prof)
        if bound then
            target_profile = prof
            bound_monitors = bound
            break
        end
    end

    if target_profile then
        local name = target_profile.name or "unnamed"

        -- Skip redundant evaluate on identical monitor configuration unless forced
        if not force
            and self.state.active_profile_name == name
            and self.state.last_monitors_sig == monitors_sig then
            return true
        end

        self:notify(string.format("Applying '%s' (%d monitors)", name, #monitors), false)
        local ok, err = pcall(target_profile.apply, bound_monitors)
        if not ok then
            self:notify(string.format("Error in '%s': %s", name, tostring(err)), true)
            return false
        end

        self.state.active_profile_name = name
        self.state.last_monitors_sig   = monitors_sig
        return true
    elseif self.fallback then
        if not force
            and self.state.active_profile_name == "__fallback__"
            and self.state.last_monitors_sig == monitors_sig then
            return true
        end

        self:notify(string.format("Applying fallback (%d monitors)", #monitors), false)
        local ok, err = pcall(self.fallback, monitors)
        if not ok then
            self:notify("Error in fallback: " .. tostring(err), true)
            return false
        end

        self.state.active_profile_name = "__fallback__"
        self.state.last_monitors_sig   = monitors_sig
        return true
    else
        self:notify(string.format("No profile matched %d monitor(s)", #monitors), false)
        return false
    end
end

function DisplayManager:reload(force)
    return self:evaluate(force or false)
end

function DisplayManager:start()
    self.state.active_instance = self
    -- Apply configuration cleanly
    self:evaluate(true)

    -- Guard listener registration across config reloads
    if not self.state.listener_registered and hl and hl.on then
        self.state.listener_registered = true
        local debounce_eval = function()
            local now = os.time()
            if now - self.state.last_eval_time >= 1 then
                self.state.last_eval_time = now
                if self.state.active_instance then
                    self.state.active_instance:evaluate(false)
                end
            end
        end
        hl.on("monitor.added", debounce_eval)
        hl.on("monitor.removed", debounce_eval)
    end

    return self
end

return DisplayManager
