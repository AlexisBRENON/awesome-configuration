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
            table.insert(module.widgets, require(module.cwd .. '/' .. entity))
        end
    end
end

function module.build(widget_type, widget_args)
    log.debug("99-custom : searching '" .. widget_type .. "' builder")
    local built = false
    -- Look after a builder able to build this widget
    for _, widget in ipairs(module.widgets) do
        built = widget.build(widget_type, widget_args)
        if built then
            break
        end
    end
    return built
end

init()
return module
