local log = require('utils/log')
local widget = require('builder/widgets')
local vicious = require('vicious')
vicious.contrib = {
    pulse = require('vicious/contrib/pulse')
}

local volume = require('backend/volume')


local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")
    local volume_model = volume.init(widget_args.device)
    for _, button in ipairs(widget_args.buttons) do
        button[3] = volume_model[button[3]]
    end
    local volume_widget = widget.build_widget(widget_args)
    widget_args.widgets = volume_widget.widget

    volume.add_widget(volume_model, volume_widget)
    vicious.register(volume_widget.text, vicious.contrib.pulse, volume[widget_args.format], widget_args.update_time, widget_args.device)
    return true
end

return builder

