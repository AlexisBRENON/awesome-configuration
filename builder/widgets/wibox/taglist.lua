local awful = require('awful')

for s = 1, screen.count() do
    config.widgets.taglist.widgets[s] = awful.widget.taglist.new(
        s,
        awful.widget.taglist.filter.all,
        config.widgets.taglist.buttons
    )
end
