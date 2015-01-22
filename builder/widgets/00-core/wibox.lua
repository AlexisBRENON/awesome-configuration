local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

local builder = {}

function builder.build(widget_type, widget_args)
    if not string.find(widget_type, '^wibox') then
        return false
    end
    print("## DEBUG ## Building wiboxes")
    for position, wibox_args in pairs(widget_args) do
        wibox_args.widgets = {}
        wibox_args.layouts = {}
        for s = wibox_args.screen or 1, wibox_args.screen or screen.count() do
            wibox_args.widgets[s] = awful.wibox({
                screen = s,
                position = position,
                height = wibox_args.height or 
                (beautiful.widgets and beautiful.widgets.wibox and ((beautiful.widgets.wibox[position] and beautiful.widgets.wibox[position].height) or beautiful.widgets.wibox.height)) or 16,
                bg = wibox_args.bg or 
                (beautiful.widgets and beautiful.widgets.wibox and ((beautiful.widgets.wibox[position] and beautiful.widgets.wibox[position].bg) or beautiful.widgets.wibox.bg)) or "#000000",
            })
            if position == 'top' or position == 'bottom' then
                wibox_args.layouts[s] = wibox.layout.align.horizontal()
            else
                wibox_args.layouts[s] = wibox.layout.align.vertical()
            end
            wibox_args.widgets[s]:set_widget(wibox_args.layouts[s])
        end
    end
    return true
end

return builder

