local log = require('utils/log')
local awful = require('awful')

local builder = {}

function builder.build(widget_type, widget_args)
    if not string.find(widget_type, '^layoutbox') then
        return false
    end
    log.debug("Building " .. widget_type)
    widget_args.widgets = {}
    for s = 1, screen.count() do
        widget_args.widgets[s] = awful.widget.layoutbox(s)
    end
    return true
end

return builder
