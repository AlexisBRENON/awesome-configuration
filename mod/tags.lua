local shifty = require("shifty")
local beautiful = require("beautiful")
local awful = require("awful")


shifty.config.tags = {}
shifty.config.tags["🌐"] = {
    position = 0,
}

shifty.config.tags["🖿"] = {
    position = 1,
}

shifty.config.tags["subl"] = {
    position = 2,
}

shifty.config.tags["🎴"] = {
    position = 3,
}

shifty.config.tags["🎥"] = {
    position = 4,
}

shifty.config.tags = awful.util.table.join(
    shifty.config.tags,
    {        
        office = {
            position = 5,
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
    exclusive = true,
}
