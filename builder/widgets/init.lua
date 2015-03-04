local log = require("utils/log")
local wibox = require('wibox')
local awful = require('awful')
local lfs = require('lfs')

local module = {
    cwd = ...
}

local function find_builders()
    local builders = {} -- Contains all sub-builder available (in decreasing priority order)
    -- List all available sub-builders (in priority order : 00, 10, 50, .., 99)
    local available_builders = {} 
    for entity in lfs.dir(module.cwd) do
        if entity:match('%d%d%-.*') and 
            lfs.attributes(module.cwd .. '/' .. entity).mode == "directory" then
            priority = entity:match('%d%d') + 0 -- Cast the string to an integer
            table.insert(available_builders,
            {
                priority = priority,
                name = module.cwd .. '/' .. entity
            })
        end
    end
    table.sort(available_builders, function(e1, e2) return e1.priority < e2.priority end)
    for _, builder in ipairs(available_builders) do
        table.insert(builders, require(builder.name))
    end
    return builders
end

local function build_widgets(widgets, builders)
    -- Loop over all widgets defined in the config
    for widget_type, widget_args in pairs(widgets) do
        log.debug("widgets : building '" .. widget_type .. "'")
        local built = false

        -- Ask each builder to build the widget, until there is one which manage
        for _, builder in pairs(builders) do
            built = builder.build(widget_type, widget_args)
            -- If the build success, go through the next widget
            if built then
                break
            end
        end
        if not built then
            log.warning("Widget builder <" .. widget_type .. "> not found.")
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
    for widget_type, widget_args in pairs(widgets) do
        -- Left outside the wibox (which is the container)
        -- and the widgets that failed to build
        if not (widget_type == 'wibox' or widget_args.widgets == nil) then
            -- Save where each widget has to be displayed
            local layout = widget_args.layout
            widgets_list[layout.edge] = widgets_list[layout.edge] or {}
            widgets_list[layout.edge][layout.alignment] = widgets_list[layout.edge][layout.alignment] or {}
            table.insert(widgets_list[layout.edge][layout.alignment], {
                index = layout.index,
                type = widget_type,
                widget = widget_args,
            })
        end
    end

    for s = 1, screen.count() do
        for edge, edge_list in pairs(widgets_list) do
            for alignment, alignment_list in pairs(edge_list) do
                local layout = wibox.layout.fixed.horizontal()
                table.sort(alignment_list, function(w1, w2) return w1.index < w2.index end)
                for _, w in pairs(alignment_list) do
                    log.debug("Assembling '" .. w.type .. "'")
                    add_widget(w.widget, layout, s)
                end
                widgets.wibox[edge].layouts[s]['set_'..alignment](widgets.wibox[edge].layouts[s], layout)
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

return module
