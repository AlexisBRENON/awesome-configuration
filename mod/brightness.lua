-- Handle brightness (with xbacklight)
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local xrandr = require("mod/xrandr")

local brightness = {
    current_backlight = 0,
    notification_id = nil,
    is_off = false,
}

-- Initialise startup backlight
local f = io.popen("xbacklight -get")
brightness.current_backlight = math.floor(tonumber(f:read("*all")))
f:close()

function brightness.update(what)
    local f = io.popen("xbacklight -get")
    brightness.current_backlight = math.floor(tonumber(f:read("*all")))
    f:close()

    local progress_bar = ""
    for i=100,0,-10 do
        if (i > brightness.current_backlight) then
            progress_bar = progress_bar .. "| |\n"
        else
            progress_bar = progress_bar .. "|X|\n"
        end
    end
    progress_bar = progress_bar .. "+-+"
    brightness.notification_id = naughty.notify({
        text = progress_bar,
        font = beautiful.font_mono,
        replaces_id = brightness.notification_id }).id
end

function brightness.increase()
    if (brightness.is_off == true) then
        xrandr.turn_on()
        brightness.is_off = false
    else
	   os.execute('xbacklight -steps 1 +10')
    end
   brightness.update()
end

function brightness.decrease()
    -- TODO : Add screen blanking when decreasing under 0
    if (brightness.current_backlight == 0) then
        xrandr.turn_off()
        brightness.is_off = true
    else
	   os.execute('xbacklight -steps 1 -10')
	   brightness.update()
    end
end

return brightness
