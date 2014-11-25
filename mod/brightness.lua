-- Handle brightness (with xbacklight)

local brightness = {}

local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

local nid = nil
function brightness.update(what)
    local f = io.popen("xbacklight -get")
    local current_backlight = math.floor(tonumber(f:read("*all")))
    f:close()

    local progress_bar = ""
    for i=100,0,-10 do
        if (i > current_backlight) then
            progress_bar = progress_bar .. "| |\n"
        else
            progress_bar = progress_bar .. "|X|\n"
        end
    end
    progress_bar = progress_bar .. "+-+"
    brightness.nid = naughty.notify({
        text = progress_bar,
        font = beautiful.font_mono,
        replaces_id = brightness.nid }).id
end

function brightness.increase()
	os.execute('xbacklight -steps 1 -time 0 +10')
	brightness.update()
end

function brightness.decrease()
    -- TODO : Add screen blanking when decreasing under 0
	os.execute('xbacklight -steps 1 -10')
	brightness.update()
end

return brightness