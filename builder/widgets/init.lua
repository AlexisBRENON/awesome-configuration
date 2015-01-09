local builders = {} -- Contains all sub-builder available (in decreasing priority order)

-- List all available sub-builders
local available_builders = io.popen('ls -1 ' .. config.main.config .. '/' .. _REQUIREDNAME)
if available_builders then
    for builder in available_builders:lines() do
        if builder ~= 'init.lua' then
            -- For each of them, ask them the list of widgets they can build
            builders:insert(require(_REQUIREDNAME .. '/' .. builder))
        end
    end
    available_builders:close()
end

-- Loop over all widgets defined in the config
for widget_type, widget_args in pairs(config.widgets) do
    local built = false
    -- Look after a builder able to build this widget
    for builder in builders do
        if builder[widget_type] then
            builder[widget_type].build(widget_args)
            built = true
        end
    end
    if not built then
        print('## ERROR ## Widget builder < ' .. widget_type .. ' > not found.')
    end
end

