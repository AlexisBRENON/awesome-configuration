local log = require("utils/log")
local widget = require("builder/widgets")
local keyboard = require('backend/keyboard')

local module = {}

function module.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")
    local keyboard_widget = widget.build_widget(widget_args)
    keyboard.add_widget(keyboard_widget)
    widget_args.widgets = keyboard_widget.widget
    return true
end

return module
