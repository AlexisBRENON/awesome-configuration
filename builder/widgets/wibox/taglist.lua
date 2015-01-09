local awful = require('awful')
local builder = {}

function builder.build(widget_args)
    widget_args.widgets = {}
    for s = 1, screen.count() do
        widget_args.widgets[s] = awful.widget.taglist.new(
            s,
            awful.widget.taglist.filter.all,
            widget_args.buttons or {}
        )
    end
end

return builder
