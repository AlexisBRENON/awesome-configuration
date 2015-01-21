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
    
local function assemble_widgets(widgets)

end

function module.build(config)
    local builders = find_builders()
    build_widgets(config, builders)
    assemble_widgets(config)
end

return module
