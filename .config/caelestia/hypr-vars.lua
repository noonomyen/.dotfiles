-- Hook hl.monitor early via DisplayManager to drop default Caelestia empty output rule
-- This prevents the laptop display from temporarily waking up during Hyprland config reloads
local DisplayManager = require("lib.display-manager")
DisplayManager.install_hook()

return {
    windowGapsIn        = 2,
    windowGapsOut       = 5,
    workspaceGaps       = 0,
    singleWindowGapsOut = 5,
    touchpadScrollFactor  = 1.0,
    touchpadDisableTyping = false,

    terminal   = "kitty",
    kbTerminal = { "SUPER + T", "CTRL + T" },
}
