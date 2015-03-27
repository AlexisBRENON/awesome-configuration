local log = require("utils/log")
-- TODO : Switch buildings based on shifty usage
local shifty = require("shifty")
local awful = require("awful")

local builder = {}

local function get_layout(layout_name)
    local layout = awful.layout.suit
    for layout_subpart in string.gmatch(layout_name, "([^.]+).?") do
        layout = layout[layout_subpart]
    end
    layout.name = layout_name

    return layout
end

function builder.build(tags)
    log.info("Building tags")
    -- Pass the tags definition to shifty
    shifty.config.tags = tags.tags

    -- Define the used tag layout in awful
    awful.layout.layouts = {}
    for _, layout_name in ipairs(tags.layouts) do
        table.insert(awful.layout.layouts,
            get_layout(layout_name))
    end
    tags.layouts = awful.layout.layouts

    -- Get the default layout of newly created tags
    tags.defaults.layout = tags.layouts[tags.defaults.layout]
    -- Pass the tags default values to shifty
    shifty.config.defaults = tags.defaults
end

return builder

