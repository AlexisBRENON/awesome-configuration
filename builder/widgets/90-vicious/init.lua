local log = require("utils/log")
local lfs = require("lfs")
local wibox = require("wibox")
local awful = require("awful")

-- Return a list of avalaible builder (containing a build() function) of this directory
local module = {
    cwd = ...,
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

function module.build(widget_args)
    log.debug("vicious : searching '" .. widget_args.type .. "' builder")
    local built = false
    -- Look after a builder able to build this widget
    if module.widgets[widget_args.type] then
        built = module.widgets[widget_args.type].build(widget_args)
    end
    return built
end

--------------------------------------------
-- These funtions are intended to be used by the submodules
-- of this module. They wrap some common code
-- -----------------------------------------

local function add_buttons(widget, widget_args)
    -- Define the mouse actions
    if widget_args.buttons then
        -- Fetch the already define shortcuts
        local buttons = widget:buttons()
        -- Add new ones
        for _, button in ipairs(widget_args.buttons) do
            buttons = awful.util.table.join(
                buttons,
                -- button[1] = modkeys
                --       [2] = button
                --       [3] = press action
                --       [4] = release action
                --       [5] = help text
                awful.button(button[1], button[2], button[3], button[4]))
        end
        -- Define the whole shortcuts
        widget:buttons(buttons)
    end
end

local function add_signals(widget, widget_args)
    -- Define the signals
    if widget_args.signals then
        for _, signal in ipairs(widget_args.signals) do
            -- signal[1] = signal name
            -- signal[2] = signal function
            widget:connect_signal(signal[1], signal[2])
        end
    end
end

local function create_container(widget_args)
    local widget
    -- Fetch the right orientation, vertical or horizontal
    if widget_args.layout.edge == 'top' or widget_args.layout.edge == 'bottom' then
        widget = wibox.layout.fixed.horizontal()
    else
        widget = wibox.layout.fixed.vertical()
    end
    return widget
end

function module.build_widget(widget_args)
    local widget = create_container(widget_args)

    -- Classic widget has : an icon, a text and a tooltip
    local icon = wibox.widget.imagebox()
    local text = wibox.widget.textbox()
    local tooltip = awful.tooltip({})

    -- Wrap these element in a container
    if widget_args.has_icon then widget:add(icon) end
    if widget_args.has_text then widget:add(text) end
    if widget_args.has_tooltip then tooltip:add_to_object(widget) end

    -- Add the mouse shortcuts
    add_buttons(widget, widget_args)
    -- Connect the signals
    add_signals(widget, widget_args)

    return {widget = widget, text = text, icon = icon, tooltip= tooltip}
end


return module
