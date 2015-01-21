local wibox = require('wibox')
local builder = {}

function builder.build(widget_type, widget_args)
    if widget_type ~= 'promptbox' then
        return false
    end
    print("## DEBUG ## Building prompts")
    widget_args.widgets = {}
    for s = widget_args.screen or 1, widget_args.screen or screen.count() do
        widget_args.widgets[s] = wibox.widget.textbox()
    end
    return true
end

return builder

