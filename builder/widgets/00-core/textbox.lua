local wibox = require('wibox')

local builder = {}

function builder.build (widget_args)
    widget_args.widget = wibox.widget.textbox()
    widget_args.widget:set_markup(widget_args.value)
end

return builder
