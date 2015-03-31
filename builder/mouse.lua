local log = require("utils/log")
local converter = require("utils/converter")

local module = {}

function module.build(mouse_config)
    log.info("Building mouse bindings")
    local buttons = converter.create_buttons(mouse_config.global)
    root.buttons(buttons)

    buttons = converter.create_buttons(mouse_config.client)
    client.buttons(buttons)
end

return module
