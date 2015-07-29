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

    -- Define the intereference between model and view
    volume_widget.model = volume_model
    volume.add_widget(volume_model, volume_widget)

    widget_args.widgets = volume_widget.widget

    if volume_model.backend.has_vicious_support then
        vicious.register(
            volume_widget,
            require(volume_model.backend.vicious_widget),
            volume[widget_args.format],
            widget_args.update_time,
            widget_args.device
        )
    end
    return true
end

return builder

