local wibox = require('wibox')

local builder = {}

function builder.build(widget_type, widget_args)
    if widget_type ~= 'systray' then
        return false
    end
    print("## DEBUG ## Building systray")
    widget_args.widget = wibox.widget.systray()
    return true
end

return builder
