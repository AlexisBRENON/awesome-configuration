local awful = require('awful')

local builder = {}

function builder.build(widget_type, widget_args)
    if not string.find(widget_type, '^tasklist') then
        return false
    end
    print("## DEBUG ## Building tasklist")
    widget_args.widgets = {}
    for s = 1, screen.count() do
        widget_args.widgets[s] = awful.widget.tasklist.new(
        s,
        awful.widget.tasklist[widget_args.filter] or awful.widget.tasklist.currenttags,
        widget_args.buttons or {},
        widget_args.style or {},
        widget_args.update_function or nil,
        widget_args.base_widget or wibox.layout.flex.horizontal)
    end
    return true
end

return builder
