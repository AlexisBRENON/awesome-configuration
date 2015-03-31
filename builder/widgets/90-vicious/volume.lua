local log = require('utils/log')
local widget = require('builder/widgets')
local vicious = require('vicious')

local volume = require('backend/volume')


local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")
    local volume_widget = widget.build_widget(widget_args)
    volume.add_widget(volume_widget)
    widget_args.widgets = volume_widget.widget

    volume = volume.init(widget_args.device)
    vicious.register(volume_widget.text, volume.device_backend_type, volume[widget_args.format], widget_args.update_time, widget_args.device)
    return true
end

return builder

