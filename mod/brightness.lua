-- Handle brightness (with xbacklight)

local brightness = {}

local awful = require("awful")
local naughty = require("naughty")

local nid = nil
function brightness.change(what)
    -- We don't really change the brightness, just report the change...
    local current = tonumber(io.lines("/sys/class/backlight/acpi_video0/actual_brightness")())
    local max = tonumber(io.lines("/sys/class/backlight/acpi_video0/max_brightness")())
    
    nid = naughty.notify({
        text = (current*100)/max .. " %",
        replaces_id = nid }).id
end

return brightness