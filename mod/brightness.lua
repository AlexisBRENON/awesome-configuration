-- Handle brightness (with xbacklight)
-- TODO : fix performance issues
--      : allow screen shutdown (with xrandr)
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

local brightness = {
    current_backlight = 0,
    notification_id = nil,
    last_call = os.time(),
    pass_call = false, -- This boolean is a workaround for my laptop which always send 2 keystrokes for brightness modifications
}

-- Initialise startup backlight
local f = io.popen("xbacklight -get")
brightness.current_backlight = math.floor(tonumber(f:read("*all"))/10)
f:close()

local function update()
    local f = io.popen("xbacklight -get")
    brightness.current_backlight = math.floor(tonumber(f:read("*all"))/10)
    f:close()

    brightness.notification_id = naughty.notify({
        text = brightness.current_backlight .. "0%",
        icon = beautiful.icons .. "/brightness/" .. brightness.current_backlight .. ".png",
        icon_size = config.widgets.wiboxes.top.size,
        replaces_id = brightness.notification_id }).id
end

local function increase()
    if (brightness.pass_call == false) then
        brightness.pass_call = true
        os.execute('xbacklight -time 1 -set ' .. brightness.current_backlight+1 .. "1")
        update()
    else
        brightness.pass_call = false
    end
end

local function decrease()
    if (brightness.pass_call == false) then
        brightness.pass_call = true
        if (brightness.current_backlight == 0 and os.time() > brightness.last_call) then
            -- Let a delay before turning off the screen
            os.execute("xset dpms force off")
        else
            os.execute('xbacklight -time 1 -set ' .. brightness.current_backlight-1 .. "1")
            update()
        end
        brightness.last_call = os.time()
    else
        brightness.pass_call = false
    end
end

brightness.increase = increase
brightness.decrease = decrease
return brightness
