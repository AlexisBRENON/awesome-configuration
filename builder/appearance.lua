local log = require("utils/log")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

local builder = {}

function builder.build(theme)
    log.info("Building theme")
    -- Load theme
    beautiful.init(theme)

    -- Set wallpaper
    if type(beautiful.wallpaper) == "table" then
        -- Allow some randomization or anything
        if beautiful.wallpaper.init then
            beautiful.wallpaper.init(beautiful.wallpaper.path)
        end
        -- Allow multiple wallpaper on multiple screen
        for s = 1, screen.count() do
            gears.wallpaper[beautiful.wallpaper.format or "maximized"](beautiful.wallpaper.get(s), s, beautiful.wallpaper.ignore_aspect or true)
        end
    else
        for s = 1, screen.count() do
            gears.wallpaper.maximized(beautiful.wallpaper, s, true)
        end
    end
end

return builder
