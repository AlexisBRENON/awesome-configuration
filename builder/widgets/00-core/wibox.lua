local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

local builder = {}

function builder.build(widget_type, widget_args)
    if widget_type ~= "wibox" then
        return false
    end
    print("## DEBUG ## Building wiboxes")
    for position, wibox_args in pairs(widget_args) do
        print("## DEBUG ## Position : ", position)
        widget_args.widgets = {}
        widget_args.layouts = {}
        for s = wibox_args.screen or 1, wibox_args.screen or screen.count() do
            widget_args.widgets[s] = awful.wibox({
                screen = s,
                position = position,
                height = wibox_args.height or 
                (beautiful.widgets and beautiful.widgets.wibox and ((beautiful.widgets.wibox[position] and beautiful.widgets.wibox[position].height) or beautiful.widgets.wibox.height)) or 16,
                bg = wibox_args.bg or 
                (beautiful.widgets and beautiful.widgets.wibox and ((beautiful.widgets.wibox[position] and beautiful.widgets.wibox[position].bg) or beautiful.widgets.wibox.bg)) or "#000000",
            })
            if position == 'top' or position == 'bottom' then
                widget_args.layouts[s] = wibox.layout.align.horizontal()
            else
                widget_args.layouts[s] = wibox.layout.align.vertical()
            end
        end
    end
    return true
end

return builder

