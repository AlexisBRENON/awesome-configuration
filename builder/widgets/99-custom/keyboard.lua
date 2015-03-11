local log = require("utils/log")

local keyboard = require('backend/keyboard')
local module = {}

function module.build(widget_args)
    if widget_args.type ~= 'keyboard' then
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

    widget_args.widgets = widget
end

return module
