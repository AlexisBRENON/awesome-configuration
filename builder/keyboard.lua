local keyboard = require('backend/keyboard')

local module = {}

function module.build(keyboard_config)
    keyboard.init(keyboard_config)
end

return module
