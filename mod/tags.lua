local shifty = require("shifty")
local beautiful = require("beautiful")
local awful = require("awful")


shifty.config.tags = {}
shifty.config.tags["🌐"] = {
    position = 0,
    exclusive = true,
}

shifty.config.tags["📁"] = {
    position = 1,
    exclusive = true,
}

shifty.config.tags = awful.util.table.join(
    shifty.config.tags,
    {
        subl = {
            position = 2,
        },
        gimp = {
            position = 3,
            exclusive = true,
            icon_only = true,
            icon = beautiful.taglist_gimp
        },
        vlc = {
            position = 4,
            exclusive = true,
            icon_only = true,
            icon = beautiful.taglist_vlc
        },
        office = {
            position = 5,
            max_clients = 1,
        },
        teamviewer = {
            position = 9,
        }
    -- TODO : to be continued
    }
)

shifty.config.defaults = {
    layout = awful.layout.layouts[1],
    persist = false,
    floatBars = true,
    guess_name = true,
    guess_position = true,
}
