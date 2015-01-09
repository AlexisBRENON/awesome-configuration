local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

local builder = {}

function builder.build (widget_args)
    for position, wibox_args in pairs(widget_args) do
        widget_args.widgets = {}
        widget_args.layouts = {}
        for s = wibox_args.screen or 1, wibox_args.screen or screen.count() do
            widget_args.widgets[s] = awful.wibox({
                screen = s,
                position = position,
                height = wibox_args.height or beautiful.widgets.wibox[position].height or beautiful.widgets.wibox.height or 16,
                bg = wibox_args.bg or beautiful.widgets.wibox[position].bg or beautiful.widgets.wibox.bg or "#000000",
           })
            if position == 'top' or position == 'bottom' then
                widget_args.layouts[s] = wibox.layout.align.horizontal()
            else
                widget_args.layouts[s] = wibox.layout.align.vertical()
            end
        end
    end
end

return builder

