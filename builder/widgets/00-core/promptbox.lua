local log = require('utils/log')
local wibox = require('wibox')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type)
    widget_args.widgets = {}
    for s = widget_args.screen or 1, widget_args.screen or screen.count() do
        widget_args.widgets[s] = wibox.widget.textbox()
    end
    require('backend/prompt').set_prompts(widget_args.widgets)

    return true
end

return builder

