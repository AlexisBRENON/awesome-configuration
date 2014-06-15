local shifty = require("shifty")
local beautiful = require("beautiful")
local awful = require("awful")


shifty.config.tags = {}
shifty.config.tags["mine"] = {
    position = 0,
    init = true,
}

shifty.config.tags["1"] = {
    position = 1,
    init = true,
}

shifty.config.tags["file"] = {
    position = 2,
}

shifty.config.tags = awful.util.table.join(
    shifty.config.tags,
    {
        test3 = {
            position = 3,
            init = true,
        }
    }
)


shifty.config.defaults = {
    layout = awful.layout.layouts[1],
    persist = false,
    floatBars = true,
    guess_name = true,
}
