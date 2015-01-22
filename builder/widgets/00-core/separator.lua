local wibox = require('wibox')

local builder = {}

function builder.build(widget_type, widget_args)
    if widget_type ~= 'separator' then
        return false
    end
    print("## DEBUG ## Building separator")
    if widget_args.type == 'text' then
        widget_args.widgets = wibox.widget.textbox()
        widget_args.widgets:set_markup(widget_args.value)
    elseif widget_args.type == 'image' then
        widget_args.widgets = wibox.widget.imagebox()
        widget_args.widgets:set_image(widget_args.value)
    end
    return true
end

return builder
