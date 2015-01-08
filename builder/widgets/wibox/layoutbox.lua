local awful = require('awful')

for s = 1, screen.count() do
    config.widgets.layoutbox.widgets[s] = awful.widget.layoutbox(s)
end
