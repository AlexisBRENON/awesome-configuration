local awful = require("awful")
local module = {}

function module.build(mouse_config)
    buttons = {}
    for _, button in pairs(mouse_config.global) do
        buttons = awful.util.table.join(buttons,
        awful.button(button[1], button[2], button[3], button[4]))
    end
    root.buttons(buttons)

    buttons = {}
    for _, button in pairs(mouse_config.client) do
        buttons = awful.util.table.join(buttons,
        awful.button(button[1], button[2], button[3], button[4]))
    end
    client.buttons(buttons)
end

return module
