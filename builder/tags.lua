-- TODO : Switch buildings based on shifty usage
local shifty = require("shifty")
local awful = require("awful")

local builder = {}

function builder.build(tags)
    shifty.config.tags = tags.tags
    tags.defaults.layout = awful.layout.suit[tags.layouts[tags.defaults.layout]]
    shifty.config.defaults = tags.defaults
end

return builder

