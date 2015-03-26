local log = require("utils/log")
local wibox = require('wibox')
local awful = require('awful')
local vicious = require('vicious')

local battery = require('backend/battery')
local super = require('builder/widgets/90-vicious')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")
    local widget = super.build_widget(widget_args)
    battery.add_widget(widget)
    widget_args.widgets = widget.widget
    vicious.register(widget.text, vicious.widgets.bat, battery[widget_args.format], widget_args.update_time, widget_args.device)
    return true
end

return builder

