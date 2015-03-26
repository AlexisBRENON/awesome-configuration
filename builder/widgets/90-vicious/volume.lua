local log = require('utils/log')
local wibox = require('wibox')
local awful = require('awful')
local vicious = require('vicious')

local volume = require('backend/volume')

local super = require('builder/widgets/90-vicious')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")
    local widget = super.build_widget(widget_args)
    volume.add_widget(widget)
    widget_args.widgets = widget.widget

    volume = volume.init(widget_args.device)
    vicious.register(widget.text, volume.device_backend_type, volume[widget_args.format], widget_args.update_time, widget_args.device)
    return true
end

return builder

