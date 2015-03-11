local log = require("utils/log")
local wibox = require('wibox')
local awful = require('awful')
local vicious = require('vicious')

local builder = {}

function builder.build(widget_args)
    if widget_args.type ~= 'datetime' then
        return false
    end
    log.debug("Building " .. widget_args.type .. " widget")
    local widget
    if widget_args.layout.edge == 'top' or widget_args.layout.edge == 'bottom' then
        widget = wibox.layout.fixed.horizontal()
    else
        widget = wibox.layout.fixed.vertical()
    end
    local text = wibox.widget.textbox()
    local icon = wibox.widget.imagebox()
    local tooltip = awful.tooltip({})

    if widget_args.has_icon then widget:add(icon) end
    if widget_args.has_text then widget:add(text) end
    if widget_args.has_tooltip then tooltip:add_to_object(widget) end
    if widget_args.buttons then
        buttons = widget:buttons()
        for _, button in ipairs(widget_args.buttons) do
            buttons = awful.util.table.join(
                buttons,
                awful.button(button[1], button[2], button[3], button[4]))
        end
        widget:buttons(buttons)
    end
    if widget_args.signals then
        for _, signal in ipairs(widget_args.signals) do
            widget:connect_signal(signal[1], signal[2])
        end
    end

    widget_args.widgets = widget
    vicious.register(text, vicious.widgets.date, widget_args.format, widget_args.update_time)
    return true
end

return builder

