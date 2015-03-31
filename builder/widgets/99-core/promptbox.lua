local log = require('utils/log')
local widget = require('builder/widgets')
local wibox = require('wibox')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type)
    widget_args.widgets = {}
    for s = widget_args.screen or 1, widget_args.screen or screen.count() do
        widget_args.widgets[s] = wibox.widget.textbox()
        widget.set_buttons(widget_args.widgets[s], widget_args.buttons)
        widget.set_signals(widget_args.widgets[s], widget_args.signals)
    end
    require('backend/prompt').set_prompts(widget_args.widgets)

    return true
end

return builder

