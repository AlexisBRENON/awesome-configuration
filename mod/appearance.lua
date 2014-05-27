local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

-- Load theme
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")
-- Link it to awful
-- awful.beautiful.register(beautiful)
-- Set background (on all screen, keep ratio)
gears.wallpaper.maximized(beautiful.wallpaper, nil, false)

-- Set cursor theme
os.execute("xsetroot -cursor_name left_ptr")
