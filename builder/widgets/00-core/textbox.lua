local wibox = require('wibox')

local builder = {}

function builder.build(widget_type, widget_args)
    if widget_type ~= 'textbox' then
        return false
    end
    print("## DEBUG ## Building textbox")
    widget_args.widget = wibox.widget.textbox()
    widget_args.widget:set_markup(widget_args.value)
    return true
end

return builder
