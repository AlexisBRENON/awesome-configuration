local log = require('utils/log')
local awful = require('awful')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args)
    widget_args.widgets = {}
    for s = 1, screen.count() do
        widget_args.widgets[s] = awful.widget.tasklist.new(
        s,
        awful.widget.tasklist[widget_args.filter] or awful.widget.tasklist.currenttags,
        widget_args.buttons or {},
        widget_args.style or {},
        widget_args.update_function or nil,
        widget_args.base_widget or wibox.layout.flex.horizontal)
    end
    return true
end

return builder
