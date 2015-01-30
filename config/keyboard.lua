local log = require("utils/log")

local module = {}

function module.load(config)
    log.info("Loading keyboard configuration")
    local keyboard = {}
    keyboard.layouts = {
        -- {layout, variant, displayed name}
        {"fr", "oss", "Français"}, -- Alternative french AZERTY
        {"us", "dvp", "Dvorak Programmeur"}, -- Dvorak for programmers
    }
    keyboard.custom_keycodes = {
        {248, 'XF86WLAN NoSymbol XF86WLAN'},
    }

    return keyboard
end

return module

