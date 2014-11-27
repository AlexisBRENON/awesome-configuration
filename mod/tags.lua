local shifty = require("shifty")
local beautiful = require("beautiful")
local awful = require("awful")


shifty.config.tags = {}

-- Init (without any name)
shifty.config.tags["\n"] = {
    position = 0,
    init = true,
}

-- Web browser
shifty.config.tags[""] = {
    position = 1,
    spawn = config.application.web_browser.bin,
}

-- File browser
shifty.config.tags[""] = {
    position = 2,
    spawn = config.application.file_browser.bin,
}

-- Sublime text / code
shifty.config.tags[""] = {
    position = 3,
    spawn = config.application.text_editor.bin,
}

-- Gimp / image management
shifty.config.tags[""] = {
    position = 4,
    spawn = config.application.image_editor.bin,
}

-- VLC / video
shifty.config.tags[""] = {
    position = 5,
    spawn = config.application.video_player.bin,
}

-- Office calc
shifty.config.tags[""] = {
    position = 6,
    spawn = config.application.office.bin,
}
-- Office writer
shifty.config.tags[""] = {
    position = 6,
    spawn = config.application.office.bin,
}
-- Office impress
shifty.config.tags[""] = {
    position = 6,
    spawn = config.application.office.bin,
}

-- Teamviewer
shifty.config.tags[""] = {
    position = 9,
    spawn = "teamviewer"
}


shifty.config.defaults = {
    layout = awful.layout.layouts[1],
    persist = false,
    floatBars = true,
    guess_name = true,
    guess_position = true,
    exclusive = true,
}
