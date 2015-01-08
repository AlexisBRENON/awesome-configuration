local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
vicious.contrib = require("vicious/contrib")
local awful = require("awful")

-- Loop over all widgets defined in the config
for widget_type, widget_args in pairs(config.widgets) do
    -- Check if it's a common widget
    if wibox.widget[widget_type] then
        -- build the classic widget
        require('builder/widgets/wibox/' .. widget_type)
    else if vicious.widget[widget_type] then
        -- build classic vicious widget
        require('builder/widgets/vicious/' .. widget_type)
    else if vicious.contrib[widget_type] then
        -- build contrib vicious widget
        require('builder/widgets/vicious/contrib/' .. widget_type)
    else
        print('## ERROR ## Unrecognized widget type : ' .. widget_type)
    end
end

