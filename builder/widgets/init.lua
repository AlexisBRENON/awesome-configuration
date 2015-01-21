local module = {
    cwd = ...
}

function module.build(config)
    local builders = {} -- Contains all sub-builder available (in decreasing priority order)
    -- List all available sub-builders
    local available_builders = io.popen('ls -1 ./' .. module.cwd)
    if available_builders then
        for builder in available_builders:lines() do
            if builder ~= 'init.lua' then
                builder = builder:gsub('%.lua', '')
                local new_builder = require(module.cwd .. '/' .. builder)
                table.insert(builders, new_builder)
            end
        end
        available_builders:close()
    end

    -- Loop over all widgets defined in the config
    for widget_type, widget_args in pairs(config) do
        print("## DEBUG ## widgets : building '", widget_type, "'")
        local built = false
        -- Look after a builder able to build this widget
        for _, builder in ipairs(builders) do
            built = builder.build(widget_type, widget_args)
            if built then
                break
            end
        end
        if not built then
            print('## WARN  ## Widget builder <' .. widget_type .. '> not found.')
        end
    end
end

return module
