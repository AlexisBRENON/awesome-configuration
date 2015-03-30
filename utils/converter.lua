local awful = require("awful")

local module = {}

function module.create_buttons(buttons)
    local result = {}
    if buttons then
        for _, button in ipairs(buttons) do
            result = awful.util.table.join(
                result,
                -- button[1] = modkeys
                --       [2] = button
                --       [3] = press action
                --       [4] = release action
                --       [5] = help text
                awful.button(button[1], button[2], button[3], button[4]))
        end
    end
    return result
end

function module.create_keys(keys)
    local result = {}
    if keys then
        for _, key in ipairs(keys) do
            result = awful.util.table.join(
                result,
                -- key[1] = modkeys
                --    [2] = key
                --    [3] = press action
                --    [4] = release action
                --    [5] = help text
                awful.key(key[1], key[2], key[3], key[4]))
        end
    end
    return result
end
 
return module
