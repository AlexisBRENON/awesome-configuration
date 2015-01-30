local log = require('utils/log')
local wibox = require('wibox')

local builder = {}

function builder.build(widget_type, widget_args)
    if not string.find(widget_type, '^textbox') then
        return false
    end
    log.debug("Building " .. widget_type)
    widget_args.widgets = wibox.widget.textbox()
    widget_args.widgets:set_markup(widget_args.value)
    return true
end

return builder
