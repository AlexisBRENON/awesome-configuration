local log = require("utils/log")
local converter = require("utils/converter")
local submodule = require("utils/submodule")
local wibox = require('wibox')
local awful = require('awful')
local lfs = require('lfs')

local module = {
    cwd = ...
}

local function find_builders()
    local builders = {} -- Contains all sub-builder available (in decreasing priority order)
    local available_builders = {} -- List all available sub-builders (in priority order : 00, 10, 50, .., 99)

    for _, module in ipairs(submodule.fetch_submodules(module.cwd)) do
        priority = string.match(submodule.get_module_name(module), '^%d%d') + 0 -- Cast the string to an integer
        table.insert(available_builders,
        {
            priority = priority,
            import_name = module
        })
    end

    table.sort(available_builders, function(e1, e2) return e1.priority < e2.priority end)
    for _, builder in ipairs(available_builders) do
        table.insert(builders, require(builder.import_name))
        builders[#builders].init()
    end
    return builders
end

local function build_widgets(widgets, builders)
    -- Loop over all widgets defined in the config
    for _, widget_args in ipairs(widgets) do
        log.debug("widgets : building '" .. widget_args.type .. "'")
        local built = false

        -- Ask each builder to build the widget, until there is one which manage
        for _, builder in pairs(builders) do
            built = builder.build(widget_args)
            -- If the build success, go through the next widget
            if built then
                break
            end
        end
        if not built then
            log.warning("Widget builder <" .. widget_args.type .. "> not found.")
        end
    end
end

local function add_widget(widget, layout, screen)
    if widget.screen == nil or widget.screen == screen then
        -- Here, it's one widget per screen (taglist, prompt, etc.)
        if widget.widgets[screen] then
            layout:add(widget.widgets[screen])
        else
            -- Here it's one widget for all screen (date/time, etc.)
            layout:add(widget.widgets)
        end
    end
end

local function assemble_widgets(widgets)
    local widgets_list = {}
    local wiboxes_list = {}
    for _, widget_args in ipairs(widgets) do
        -- Left outside the widgets that failed to build
        if widget_args.widgets ~= nil then
            -- If the widget is not a wibox (which is the container)
            if widget_args.type ~= 'wibox' then
                -- Save where each widget has to be displayed
                local layout = widget_args.layout
                widgets_list[layout.edge] = widgets_list[layout.edge] or {}
                widgets_list[layout.edge][layout.alignment] = widgets_list[layout.edge][layout.alignment] or {}
                table.insert(widgets_list[layout.edge][layout.alignment], {
                    index = layout.index,
                    widget = widget_args,
                })
            else
                wiboxes_list[widget_args.position] = widget_args
            end
        end
    end
    for s = 1, screen.count() do
        for edge, edge_list in pairs(widgets_list) do
            for alignment, alignment_list in pairs(edge_list) do
                local layout = wibox.layout.fixed.horizontal()
                table.sort(alignment_list, function(w1, w2) return w1.index < w2.index end)
                for _, w in pairs(alignment_list) do
                    log.debug("Assembling '" .. w.widget.type .. "'")
                    add_widget(w.widget, layout, s)
                end
                wiboxes_list[edge].layouts[s]['set_'..alignment](wiboxes_list[edge].layouts[s], layout)
            end
        end
    end
end

function module.build(config)
    log.info("Building widgets")
    local builders = find_builders()
    build_widgets(config, builders)
    assemble_widgets(config)
end

-- ------------------------------------------------------------
-- Functions commonly used by widgets builder
--

function module.set_buttons(widget, new_buttons)
    -- Define the mouse actions
    if new_buttons then
        -- Fetch the already define shortcuts
        local buttons = widget:buttons()
        -- Add new ones
        buttons = awful.util.table.join(
            buttons,
            converter.create_buttons(new_buttons)
            )
        -- Define the whole shortcuts
        widget:buttons(buttons)
    end
end

function module.set_signals(widget, signals)
    -- Define the signals
    if signals then
        for _, signal in ipairs(signals) do
            -- signal[1] = signal name
            -- signal[2] = signal function
            widget:connect_signal(signal[1], signal[2])
        end
    end
end

function module.create_container(widget_args)
    local container
    -- Fetch the right orientation, vertical or horizontal
    if widget_args.layout.edge == 'top' or widget_args.layout.edge == 'bottom' then
        container = wibox.layout.fixed.horizontal()
    else
        container = wibox.layout.fixed.vertical()
    end
    return container
end

function module.build_widget(widget_args)
    local container = module.create_container(widget_args)

    -- Classic widget has : an icon, a text and a tooltip
    local icon = wibox.widget.imagebox(
        widget_args.icon)
    local text = wibox.widget.textbox(
        widget_args.text)
    local tooltip = awful.tooltip({})

    -- Wrap these element in a container
    if widget_args.has_icon then container:add(icon) end
    if widget_args.has_text then container:add(text) end
    if widget_args.has_tooltip then tooltip:add_to_object(container) end

    -- Add the mouse shortcuts
    module.set_buttons(container, widget_args.buttons)
    -- Connect the signals
    module.set_signals(container, widget_args.signals)

    return {widget = container, text = text, icon = icon, tooltip= tooltip}
end

return module
