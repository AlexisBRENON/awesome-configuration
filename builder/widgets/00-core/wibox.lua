local log = require('utils/log')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

local builder = {}

function builder.build(widget_args)
    if widget_args.type ~= 'wibox' then
        return false
    end
    log.debug("Building " .. widget_args.type)
    widget_args.widgets = {}
    widget_args.layouts = {}
    for s = widget_args.screen or 1, widget_args.screen or screen.count() do
        widget_args.widgets[s] = awful.wibox({
            screen = s,
            position = widget_args.position,
            height = widget_args.height or 
            (beautiful.widgets and beautiful.widgets.wibox and ((beautiful.widgets.wibox[position] and beautiful.widgets.wibox[position].height) or beautiful.widgets.wibox.height)) or 16,
            bg = widget_args.bg or 
            (beautiful.widgets and beautiful.widgets.wibox and ((beautiful.widgets.wibox[position] and beautiful.widgets.wibox[position].bg) or beautiful.widgets.wibox.bg)) or "#000000",
        })
        if widget_args.position == 'top' or widget_args.position == 'bottom' then
            widget_args.layouts[s] = wibox.layout.align.horizontal()
        else
            widget_args.layouts[s] = wibox.layout.align.vertical()
        end
        widget_args.widgets[s]:set_widget(widget_args.layouts[s])
    end
    return true
end

return builder

