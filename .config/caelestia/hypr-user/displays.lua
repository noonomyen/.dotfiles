local DisplayManager = require("lib.display-manager")
local dm = DisplayManager.new()

-- Profile 1: Single Monitor (Laptop display only)
dm:add_profile({
    name = "config_1",
    match = {
        laptop = { model = "0x004D" },
    },
    apply = function(m)
        hl.monitor({
            output   = m.laptop.name,
            mode     = "1920x1080@144",
            position = "0x0",
            scale    = 1,
            disabled = false,
        })
        hl.config({
            cursor = {
                default_monitor = m.laptop.name,
            },
        })
    end,
})

-- Profile 12: Dual Monitor (External 2K 120Hz, Internal disabled)
dm:add_profile({
    name = "config_12",
    match = {
        laptop = { model = "0x004D" },
        ext    = { model = "ARZOPA-27" },
    },
    apply = function(m)
        hl.monitor({
            output   = m.ext.name,
            mode     = "2560x1440@120",
            position = "0x0",
            scale    = 1,
            disabled = false,
        })
        hl.monitor({
            output   = m.laptop.name,
            disabled = true,
        })
        hl.config({
            cursor = {
                default_monitor = m.ext.name,
            },
        })
    end,
})

-- Fallback for unconfigured monitors
dm:set_fallback(function(monitors)
    for _, mon in ipairs(monitors) do
        hl.monitor({
            output   = mon.name,
            mode     = "preferred",
            position = "auto",
            scale    = 1,
            disabled = false,
        })
    end
end)

-- Start watching monitor events and apply current state
dm:start()

return dm
