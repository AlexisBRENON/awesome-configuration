local wibox = require('wibox')
local awful = require('awful')

local module = {
    cwd = ...
}

local function find_builders()
    local builders = {} -- Contains all sub-builder available (in decreasing priority order)
    -- List all available sub-builders (in priority order : 00, 10, 50, .., 99)
    -- TODO : Use a more lua-way to do this
    local available_builders = io.popen('ls -1 ./' .. module.cwd)
    if available_builders then
        for builder in available_builders:lines() do
            -- init.lua is the current file and is not an actual builder
            if builder ~= 'init.lua' then
                -- For the 'require' call, we have to remove the extension
                builder = builder:gsub('%.lua', '')
                table.insert(builders, require(module.cwd .. '/' .. builder))
            end
        end
        available_builders:close()
    end
    return builders
end

local function build_widgets(widgets, builders)
    -- Loop over all widgets defined in the config
    for widget_type, widget_args in pairs(widgets) do
        print("## DEBUG ## widgets : building '" .. widget_type .. "'")
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
            print('## WARN  ## Widget builder <' .. widget_type .. '> not found.')
        end
    end
end

local function add_widget(widget, layout, screen)
    if widget.screen == nil or widget.screen == screen then
        -- Here, it's one widget per screen (taglist, prompt, etc.)
        if widget.widget[screen] then
            layout:add(widget.widget[screen])
        else
            -- Here it's one widget for all screen (date/time, etc.)
            layout:add(widget.widget)
        end
    end
end

local function assemble_widgets(widgets)
    local widget_list = {}
    for widget_type, widget_args in pairs(widgets) do
        -- Left outside the wibox (which is the container)
        -- and the widgets that failed to build
        if not (widget_type == 'wibox' or widget_args.widgets == nil) then
            -- Save where each widget has to be displayed
            local layout_info = widget_args.layout
            widget_list[layout_info.wibox] = widget_list[layout_info.wibox] or {}
            widget_list[layout_info.wibox][layout_info.position] = widget_list[layout_info.wibox][layout_info.position] or {}
            table.insert(widget_list[layout_info.wibox][layout_info.position], {
                index = layout_info.index,
                widget = widget_args.widgets,
                screen = widget_args.screen
            })
        end
    end

    for s = 1, screen.count() do
        print("## DEBUG ## Screen s : " .. s)
        for wibox_pos, wibox_args in pairs(widgets.wibox) do
            print("## DEBUG ## wibox_pos : " .. wibox_pos)
            for i, v in pairs(wibox_args) do
                print("## DEBUG ## ", i, " : ", v)
            end
            for position, widgets in pairs(widget_list[wibox_pos]) do
                print("## DEBUG ## position : " .. position)
                -- List widgets in the index order
                table.sort(widgets, function(w1, w2) return w2.index < w1.index end)
                for i, v in pairs(widgets) do
                    print("## DEBUG ## ", i, " : ", v)
                end
                local layout
                if wibox_pos == 'top' or wibox_pos == 'bottom' then
                    layout = wibox.layout.fixed.horizontal()
                else
                    layout = wibox.layout.fixed.vertical()
                end
                for _, widget in ipairs(widgets) do
                    add_widget(widget, layout, s)
                end
                wibox_args.layouts[s]['set_'..position](wibox_args.layouts[s], layout)
            end
        end
    end
end

function module.build(config)
    local builders = find_builders()
    build_widgets(config, builders)
    assemble_widgets(config)
end

return module
