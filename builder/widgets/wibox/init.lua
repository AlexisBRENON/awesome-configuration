-- Return a list of avalaible builder (containing a build() function) of this directory
local widgets = {}

local available_widgets = io.popen('ls -1 ' .. config.main.config .. '/' .. _REQUIREDNAME)
if available_widgets then
    for widget in available_widgets:lines() do
        -- For each item in the directory except the current file
        if widget ~= 'init.lua' then
            -- Add it to the returned table to allow main builder to call sub-builders
            widgets[widget] = require(_REQUIREDNAME .. '/' .. widget)
        end
    end
    available_widgets:close()
end

return widgets
