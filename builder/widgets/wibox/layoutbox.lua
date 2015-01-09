local awful = require('awful')
local builder = {}

function builder.build (widget_args)
    widget_args.widgets = {}
    for s = 1, screen.count() do
        widget_args.widgets[s] = awful.widget.layoutbox(s)
    end
end

return builder
