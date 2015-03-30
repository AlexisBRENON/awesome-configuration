local log = require('utils/log')
local converter = require('utils/converter')
local awful = require('awful')

local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type)
    widget_args.widgets = {}
    for s = 1, screen.count() do
        widget_args.widgets[s] = awful.widget.taglist.new(
        s,
        awful.widget.taglist.filter.all,
        converter.create_buttons(widget_args.buttons)
        )
    end
    -- TODO : Support installation without shifty
    local shifty = require("shifty")
    shifty.taglist = widget_args.widgets
    shifty.init()
    return true
end

return builder
