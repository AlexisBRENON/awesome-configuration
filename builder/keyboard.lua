local log = require("utils/log")
local keyboard = require('backend/keyboard')

local module = {}

function module.build(keyboard_config)
    log.info("Building keyboard")
    keyboard.init(keyboard_config)
end

return module
