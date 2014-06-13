local shifty = require("shifty")
local beautiful = require("beautiful")
local awful = require("awful")


shifty.config.tags = {}
shifty.config.tags["🌐"] = {
    index = 1,
    exclusive = true,
    spawn = config.application.web_browser.bin,
}

shifty.config.tags["📁"] = {
    index = 2,
    exclusive = true,
    spawn = config.application.file_browser.bin,
}

shifty.config.tags = {
    gimp = {
        exclusive = true,
        icon_only = true,
        icon = beautiful.taglist_image
    },
    vlc = {
        exclusive = true,
        icon_only = true,
        icon = beautiful.taglist_video
    }
    -- TODO : to be continued
}

shifty.config.defaults = {
    layout = awful.layout.layouts[1],
    persist = false,
    floatBars = true,
    guess_name = true,
}
