local log = require("utils/log")

-- Return a list of avalaible builder (containing a build() function) of this directory
local module = {
    cwd = ...,
    widgets = {}
}

function init()
    local available_widgets = io.popen('ls -1 ./' .. module.cwd)
    if available_widgets then
        for widget in available_widgets:lines() do
            -- For each item in the directory except the current file
            if widget ~= 'init.lua' then
                widget = widget:gsub('%.lua', '')
                -- Add it to the returned table to allow main builder to call sub-builders
                table.insert(module.widgets, require(module.cwd .. '/' .. widget))
            end
        end
        available_widgets:close()
    end
end

function module.build(widget_type, widget_args)
    log.debug("20-vicious : searching '" .. widget_type .. "' builder")
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
