local log = require("utils/log")
local widget = require('builder/widgets')
local vicious = require('vicious')

local battery = require('backend/battery')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")
    local battery_widget = widget.build_widget(widget_args)
    battery.add_widget(battery_widget)
    widget_args.widgets = battery_widget.widget
    vicious.register(battery_widget.text, vicious.widgets.bat, battery[widget_args.format], widget_args.update_time, widget_args.device)
    return true
end

return builder

