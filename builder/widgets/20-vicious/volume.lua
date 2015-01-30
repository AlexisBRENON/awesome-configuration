local log = require('utils/log')
local wibox = require('wibox')
local awful = require('awful')
local vicious = require('vicious')

local volume = require('backend/volume')

local builder = {}

function builder.build(widget_type, widget_args)
    if not string.find(widget_type, '^volume') then
        return false
    end
    log.debug("Building " .. widget_type .. " widget")
    local widget
    if widget_args.layout.edge == 'top' or widget_args.layout.edge == 'bottom' then
        widget = wibox.layout.fixed.horizontal()
    else
        widget = wibox.layout.fixed.vertical()
    end
    local text = wibox.widget.textbox()
    local icon = wibox.widget.imagebox()
    local tooltip = awful.tooltip({})
    volume = volume.init({text = text, icon = icon, tooltip = tooltip})

    if widget_args.has_icon then widget:add(icon) end
    if widget_args.has_text then widget:add(text) end
    if widget_args.has_tooltip then tooltip:add_to_object(widget) end

    widget_args.widgets = widget
    vicious.register(text, vicious.widgets.volume, volume[widget_args.format], widget_args.update_time, widget_args.device)
    return true
end

return builder

