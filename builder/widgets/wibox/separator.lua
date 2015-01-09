local wibox = require('wibox')

local builder = {}

function builder.build (widget_args)
    if widget_args.type == 'text' then
        widget_args.widget = wibox.widget.textbox()
        widget_args.widget:set_markup(widget_args.value)
    else if widget_args.type == 'image' then
        widget_args.widget = wibox.widget.imagebox()
        widget_args.widget:set_image(widget_args.value)
    end
end

return builder
