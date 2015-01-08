local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

-- Load theme
beautiful.init(config.main.theme)

-- Set wallpaper
-- Allow some randomization or anything
if beautiful.wallpaper.init then
    beautiful.wallpaper.init()
end
-- Allow multiple wallpaper on multiple screen
if beautiful.wallpaper.get then
    for s = 1, screen.count() do
        gears.wallpaper[beautiful.wallpaper.format](beautiful.wallpaper.get(s), s, beautiful.wallpaper.ignore_aspect)
    end
else
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
