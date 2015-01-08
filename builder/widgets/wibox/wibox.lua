local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

for position, wibox_args in pairs(config.widgets.wibox) do
    for s = wibox_args.screen or 1, wibox_args.screen or screen.count() do
        config.widget.wibox[position].widgets[s] = awful.wibox({
            screen = s,
            position = position,
            height = wibox_args.height or beautiful.widgets.wibox[position].height or beautiful.widgets.wibox.height or 16,
            bg = wibox_args.bg or beautiful.widgets.wibox[position].bg or beautiful.widgets.wibox.bg or "#000000",
        })
        if position == 'top' or position == 'bottom' then
            config.widget.wibox[position].layouts[s] = wibox_args.layout or wibox.layout.align.horizontal()
        else
            config.widget.wibox[position].layouts[s] = wibox_args.layout or wibox.layout.align.vertical()
        end
    end
end

