local log = require('utils/log')
local wibox = require('wibox')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type)
    widget_args.widgets = wibox.widget.textbox()
    widget_args.widgets:set_markup(widget_args.value)
    return true
end

return builder
