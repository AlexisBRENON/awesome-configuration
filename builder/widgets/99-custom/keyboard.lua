local log = require("utils/log")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful") 

local keyboard = require('backend/keyboard')
local module = {}

function module.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")
    local widget
    if widget_args.layout.edge == 'top' or widget_args.layout.edge == 'bottom' then
        widget = wibox.layout.fixed.horizontal()
    else
        widget = wibox.layout.fixed.vertical()
    end
    local text = wibox.widget.textbox(
        widget_args.text or nil)
    local icon = wibox.widget.imagebox(
        (widget_args.icon and beautiful.icons .. '/' .. widget_args.icon) or nil)
    local tooltip = awful.tooltip({})
    keyboard.add_widget({text = text, icon = icon, tooltip = tooltip})

    if widget_args.has_icon then widget:add(icon) end
    if widget_args.has_text then widget:add(text) end
    if widget_args.has_tooltip then tooltip:add_to_object(widget) end

    widget_args.widgets = widget

    return true
end

return module
