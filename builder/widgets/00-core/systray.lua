local wibox = require('wibox')

local builder = {}

function builder.build(widget_type, widget_args)
    if not string.find(widget_type, '^systray') then
        return false
    end
    print("## DEBUG ## Building systray")
    widget_args.widgets = wibox.widget.systray()
    return true
end

return builder
