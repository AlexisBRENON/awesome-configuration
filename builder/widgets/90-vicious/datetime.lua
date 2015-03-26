local log = require("utils/log")
local wibox = require('wibox')
local awful = require('awful')
local vicious = require('vicious')

local super = require('builder/widgets/90-vicious')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")

    local widget = super.build_widget(widget_args)
    widget_args.widgets = widget.widget

    vicious.register(widget.text, vicious.widgets.date, widget_args.format, widget_args.update_time)

    return true
end

return builder

