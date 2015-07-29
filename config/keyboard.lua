local log = require("utils/log")

local keyboard = {}

function keyboard.load(config)
    log.info("Loading keyboard configuration")
    keyboard.layouts = {
        -- {layout, variant, displayed name}
        {"fr", "oss", "Français"}, -- Alternative french AZERTY
        {"us", "dvp", "Dvorak Programmeur"}, -- Dvorak for programmers
    }
    keyboard.custom_keycodes = {
        {248, 'XF86WLAN NoSymbol XF86WLAN'},
    }
    
    keyboard.load = nil
    return keyboard
end

return keyboard

