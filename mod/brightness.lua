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
    os.execute('xbacklight -set ' .. brightness.current_backlight+1 .. "1")
    update()
end

local function decrease()
    if (brightness.current_backlight == 0 and os.time() > brightness.last_call) then
        -- Let a delay before turning off the screen
        os.execute("sleep 1 ; xset dpms force off")
    else
        os.execute('xbacklight -set ' .. brightness.current_backlight-1 .. "1")
        update()
    end
    brightness.last_call = os.time()
end

brightness.increase = increase
brightness.decrease = decrease
return brightness
