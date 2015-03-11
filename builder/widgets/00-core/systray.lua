local log = require('utils/log')
local wibox = require('wibox')

local builder = {}

function builder.build(widget_args)
    if widget_args.type ~= 'systray' then
        return false
    end
    log.debug("Building " .. widget_args.type)
    widget_args.widgets = wibox.widget.systray()
    return true
end

return builder
