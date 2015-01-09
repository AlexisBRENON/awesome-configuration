local wibox = require('wibox')

local builder = {}

function builder.build (widget_args)
    widget_args.widget = wibox.widget.systray()
end

return builder
