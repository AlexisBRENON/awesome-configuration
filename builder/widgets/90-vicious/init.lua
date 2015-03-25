local log = require("utils/log")
local lfs = require("lfs")

-- Return a list of avalaible builder (containing a build() function) of this directory
local module = {
    cwd = ...,
    common_functions = {},
}

function module.init()
    if module.widgets == nil then
        module.widgets = {}
        for entity in lfs.dir(module.cwd) do
            -- For each item in the directory except the current file
            if entity:match("^.*%.lua$") and
                entity ~= 'init.lua' then
                entity = entity:gsub('%.lua', '')
                -- Add it to the returned table to allow main builder to call sub-builders
                module.widgets[entity] = require(module.cwd .. '/' .. entity)
            end
        end
    end
end


--------------------------------------------
-- These funtions are intended to be used by the submodules
-- of this module. They wrap some common code
-- -----------------------------------------

function module.common_functions.build_widget(widget_args)
    local wibox = require("wibox")
    local awful = require("awful")
    local widget -- The resulting widget

    -- Fetch the right orientation, vertical or horizontal
    if widget_args.layout.edge == 'top' or widget_args.layout.edge == 'bottom' then
        widget = wibox.layout.fixed.horizontal()
    else
        widget = wibox.layout.fixed.vertical()
    end

    -- Classic widget has : an icon, a text and a tooltip
    local icon = wibox.widget.imagebox()
    local text = wibox.widget.textbox()
    local tooltip = awful.tooltip({})

    -- Wrap these element in a container
    if widget_args.has_icon then widget:add(icon) end
    if widget_args.has_text then widget:add(text) end
    if widget_args.has_tooltip then tooltip:add_to_object(widget) end

    -- Define the mouse actions
    if widget_args.buttons then
        buttons = widget:buttons()
        for _, button in ipairs(widget_args.buttons) do
            buttons = awful.util.table.join(
                buttons,
                awful.button(button[1], button[2], button[3], button[4]))
        end
        widget:buttons(buttons)
    end

    -- Define the signals
    if widget_args.signals then
        for _, signal in ipairs(widget_args.signals) do
            widget:connect_signal(signal[1], signal[2])
        end
    end

    return {widget = widget, text = text, icon = icon, tooltip= tooltip}
end




function module.build(widget_args)
    log.debug("vicious : searching '" .. widget_args.type .. "' builder")
    local built = false
    -- Look after a builder able to build this widget
    if module.widgets[widget_args.type] then
        built = module.widgets[widget_args.type].build(widget_args)
    end
    return built
end

return module
