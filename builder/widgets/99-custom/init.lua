local log = require("utils/log")
local lfs = require("lfs")

-- Return a list of avalaible builder (containing a build() function) of this directory
local module = {
    cwd = ...,
    widgets = {}
}

function init()
    local available_builders = {} 
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

function module.build(widget_args)
    log.debug("99-custom : searching '" .. widget_args.type .. "' builder")
    local built = false
    -- Look after a builder able to build this widget
    if module.widgets[widget_args.type] then
        built = module.widgets[widget_args.type].build(widget_args)
    end
    return built
end

init()
return module
