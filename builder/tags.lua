-- TODO : Switch buildings based on shifty usage
local shifty = require("shifty")

local builder = {}

function builder.build(tags)
    shifty.config.tags = tags.tags
    shifty.config.defaults = tags.defaults
end

return builder

