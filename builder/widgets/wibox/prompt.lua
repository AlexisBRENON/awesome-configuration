local wibox = require('wibox')
local builder = {}

function builder.build (widget_args)
    widget_args.widgets = {}
    for s = widget_args.screen or 1, widget_args.screen or screen.count() do
        widget_args.widgets[s] = wibox.widget.textbox()
    end
end

return builder

