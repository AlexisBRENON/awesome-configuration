-- Handle brightness (with xbacklight)
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

local brightness = {}

local current_backlight = 0
local notification_id = nil
local last_call = os.time()

-- Initialise startup backlight
local f = io.popen("xbacklight -get")
current_backlight = math.floor(tonumber(f:read("*all"))/10)
f:close()

local function update()
  local f = io.popen("xbacklight -get")
  current_backlight = math.floor(tonumber(f:read("*all"))/10)
  f:close()

  notification_id = naughty.notify({
    text = current_backlight .. "0%",
    icon = beautiful.icons .. "/brightness/" .. current_backlight .. ".png",
    icon_size = config.widgets.wiboxes.top.size,
    replaces_id = notification_id }).id
end

local function increase()
  os.execute('xbacklight -set ' .. current_backlight+1 .. "1")
  update()
end

local function decrease()
  if (current_backlight == 0 and os.time() > last_call) then
    -- Let a delay before turning off the screen
    os.execute("sleep 1 ; xset dpms force off")
  else
    os.execute('xbacklight -set ' .. current_backlight-1 .. "1")
    update()
  end
  last_call = os.time()
end

brightness.increase = increase
brightness.decrease = decrease
return brightness
