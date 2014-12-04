local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

-- Load theme
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")
-- Link it to awful
-- awful.beautiful.register(beautiful)
-- Set background
for s = 1, screen.count() do
  gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

-- Set cursor theme
os.execute("xsetroot -cursor_name left_ptr")
