local shifty = require("shifty")
local beautiful = require("beautiful")
local awful = require("awful")


shifty.config.tags = {}
-- Web browser
shifty.config.tags[""] = {
    position = 0,
}

-- File browser
shifty.config.tags[""] = {
    position = 1,
}

-- Sublime text / code
shifty.config.tags[""] = {
    position = 2,
}

-- Gimp / image management
shifty.config.tags[""] = {
    position = 3,
}

-- VLC / video
shifty.config.tags[""] = {
    position = 4,
}

-- Office writer
shifty.config.tags[""] = {
    position = 5,
}
-- Office calc
shifty.config.tags[""] = {
    position = 5,
}
-- Office impress
shifty.config.tags[""] = {
    position = 5,
}

-- Teamviewer
shifty.config.tags[""] = {
    position = 9,
}


shifty.config.defaults = {
    layout = awful.layout.layouts[1],
    persist = false,
    floatBars = true,
    guess_name = true,
    guess_position = true,
    exclusive = true,
}
