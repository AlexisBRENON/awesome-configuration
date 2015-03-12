local awful = require("awful")
local naughty = require("naughty")
local vicious = require("vicious")
vicious.contrib = {
    pulse = require("vicious/contrib/pulse")
}
local beautiful = require("beautiful")

local module = {
    widgets = {} -- widgets to link to the volume level
}

local function add_widget(widget)
    table.insert(module.widgets, widget)
end

local function update()
    vicious.force({module.text}) -- Update the volume widget
end

local function increase()
    vicious.contrib.pulse.add(5, module.device)
    update()
end

local function decrease()
    vicious.contrib.pulse.add(-5, module.device)
    update()
end

local function toggle()
    vicious.contrib.pulse.toggle(module.device)
    update()
end

-- run pavucontrol
local function mixer()
    awful.util.spawn("pavucontrol", false)
end

local function set_icon(state, level)
    local icon_path = "widgets/volume/"        
    if state == "off" then
        icon_path = icon_path .. "mute.png"
    else
        icon_path = icon_path .. math.floor(tonumber(level)/10) .. ".png"
    end
    for _, widget in ipairs(module.widgets) do
        widget.icon:set_image(beautiful.icons .. icon_path)
    end
end

local function notify(state, level)
    -- TODO : Implement me !
end

local function vicious_format(widget, args)
    local state = args[2]
    local level = args[1]
    local result = ""

    if state == "off" then
        result = "Muted"
    else
        result = level .. "%"
    end
    set_icon(state, level)

    return result
end


-- Define public interface
module.increase = increase
module.decrease = decrease
module.toggle = toggle
module.mixer = mixer

module.add_widget = add_widget
module.vicious_format = vicious_format

return module
