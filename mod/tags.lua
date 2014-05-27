local shifty = require("shifty")
local beautiful = require("beautiful")


shifty.config.tags = {
    home = {
        position = 1,
        exclusive = true,
        max_client = 0,
        init = true,
        icon_only = true,
        icon = beautiful.taglist_home
    },
    web = {
        position = 2,
        exclusive = true,
        spawn = config.application.web_browser.bin,
        icon_only = true,
        icon = beautiful.taglist_web
    },
    file = {
        position = 3,
        exclusive = true,
        spawn = config.application.file_browser.bin,
        icon_only = true,
        icon = beautiful.taglist_file
    },
    gimp = {
        icon_only = true,
        icon = beautiful.taglist_image
    },
    vlc = {
        icon_only = true,
        icon = beautiful.taglist_video
    }
    -- TODO : to be continued
}


shifty.config.defaults = {
    layout = config.layouts[1],
    persist = false,
    floatBars = true,
    guess_name = true,
    guess_position = true,
}
