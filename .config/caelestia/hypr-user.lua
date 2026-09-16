-- GPU configuration (Intel iGPU - muxless laptop via udev symlink)
hl.env("AQ_DRM_DEVICES", "/dev/dri/igpu")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "mesa")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Base configuration
hl.config({
    input = {
        kb_layout     = "us,th",
        kb_options    = "grp:caps_toggle",
        accel_profile = "flat",
        scroll_factor = 2.0,
    },
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
    },
})

-- Keep acceleration on touchpad only
hl.device({
    name          = "elan1203:00-04f3:307a-touchpad",
    accel_profile = "adaptive",
})

-- Load display configurations & management
require("hypr-user.displays")

-- Load hyprexpo plugin dynamically
local user = os.getenv("USER") or "default"
pcall(function()
    hl.plugin.load("/var/cache/hyprpm/" .. user .. "/hyprexpo/hyprexpo.so")
end)

-- Hyprexpo Overview toggle (SUPER + TAB)
hl.bind("SUPER + TAB", function()
    if hl.plugin and hl.plugin.hyprexpo then
        hl.plugin.hyprexpo.expo("toggle")
    end
end)

-- Hyprexpo plugin config
hl.config({
    plugin = {
        hyprexpo = {
            columns          = 3,
            gaps_in          = 5,
            gaps_out         = 5,
            bg_col           = "rgb(11111b)",
            workspace_method = "center current",
        },
    },
})

-- Force terminals opaque (kitty renders with background_opacity otherwise)
hl.window_rule({ match = { class = "kitty" }, opaque = true })
