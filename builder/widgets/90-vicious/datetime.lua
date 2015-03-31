local log = require("utils/log")
local widget = require("builder/widgets")
local vicious = require('vicious')


local builder = {}

function builder.build(widget_args)
    log.debug("Building " .. widget_args.type .. " widget")

    local date_widget = widget.build_widget(widget_args)
    widget_args.widgets = date_widget.widget

    vicious.register(date_widget.text, vicious.widgets.date, widget_args.format, widget_args.update_time)

    return true
end

return builder

