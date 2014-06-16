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
        gimp = {
            exclusive = true,
            icon_only = true,
            icon = beautiful.taglist_gimp
        },
        vlc = {
            exclusive = true,
            icon_only = true,
            icon = beautiful.taglist_vlc
        }
    -- TODO : to be continued
    }
)

shifty.config.defaults = {
    layout = awful.layout.layouts[1],
    persist = false,
    floatBars = true,
    guess_name = true,
}
