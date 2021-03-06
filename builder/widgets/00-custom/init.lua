local log = require("utils/log")
local submodule = require("utils/submodule")

-- Return a list of avalaible builder (containing a build() function) of this directory
local module = {
    cwd = ...,
    widgets = {}
}

function module.init()
    local available_builders = {}

    for _, submodule_import_name in ipairs(submodule.fetch_submodules(module.cwd)) do
        module.widgets[submodule.get_module_name(submodule_import_name)] =
        require(submodule_import_name)
    end
end

function module.build(widget_args)
    log.debug("custom : searching '" .. widget_args.type .. "' builder")
    local built = false
    -- Look after a builder able to build this widget
    if module.widgets[widget_args.type] then
        built = module.widgets[widget_args.type].build(widget_args)
    end
    return built
end

return module
