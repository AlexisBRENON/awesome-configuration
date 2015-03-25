local log = require("utils/log")
local datetime = require("backend/datetime")

local module = {}

function module.load(config)
    log.info("Loading widgets configuration")
    local widgets = {
        -- Start with common widgets
        {
            type = "wibox",
            position = "top", -- I want a wibox on top
        },
        -- No wibox on bottom or sides
        --[[
        {
            type = "wibox",
            position = "bottom",
        },
        --]]
        {
            type = "promptbox",
            layout = {
                edge = 'top',
                alignment = 'left',
                index = 100, -- right most
            }
        },
        {
            type = "taglist",
            layout = {
                edge = 'top',
                alignment = 'left',
                index = 50,
            }
        },
        {
            type = "layoutbox",
            layout = {
                edge = 'top',
                alignment = 'left',
                index = 0, -- Left most widget
            }
        },
        {
            type = "systray",
            screen = 1, -- Only on screen 1
            layout = {
                edge = 'top', -- Add it to the top wibox
                alignment = 'right', -- On the right
                index = 0, -- Left most
            },
        },
        {
            type = "textbox",
            value = "  ",
            screen = 1,
            layout = {
                edge = 'top',
                alignment = 'right',
                index = 1,
            },
        },
        -- Then declare custom ones
        {
            type = "datetime",
            has_text = true,
            update_time = 61,
            format = "%a %d/%m, %H:%M",
            layout = {
                edge = 'top', -- Add it to the top wibox
                alignment = 'right', -- On the right
                index = 100, -- Right most
            },
            buttons = {
                { {}, 3, function() datetime.calendar.show_calendar(-1) end, nil },
                { {}, 1, function() datetime.calendar.show_calendar(1) end, nil },
            },
            signals = {
                { "mouse::enter", function() datetime.calendar.show_calendar(0) end },
                { "mouse::leave", datetime.calendar.hide_calendar},
            },
        },
        {
            type = "textbox",
            value = "  ",
            layout = {
                edge = 'top',
                alignment = 'right',
                index = 99,
            },
        },
        {
            type = "battery",
            has_text = true,
            has_icon = true,
            has_tooltip = true,
            update_time = 59,
            device = "BAT0",
            format = "update_icon_percent",
            layout = {
                edge = 'top', -- Add it to the top wibox
                alignment = 'right', -- On the right
                index = 30, 
            },
        },
        {
            type = "textbox",
            value = "  ",
            layout = {
                edge = 'top',
                alignment = 'right',
                index = 29,
            },
        },
        {
            type = "volume",
            has_text = true,
            has_icon = true,
            has_tooltip = false,
            update_time = 3631,
            device = "alsa_output.pci-0000_00_1b.0.analog-stereo",
            format = "vicious_format",
            screen = 1,
            layout = {
                edge = 'top', -- Add it to the top wibox
                alignment = 'right', -- On the right
                index = 40, 
            },
        },
        {
            type = "textbox",
            value = "  ",
            layout = {
                edge = 'top',
                alignment = 'right',
                index = 39,
            },
        },
        {
            type = "keyboard",
            has_text = false,
            has_icon = true,
            has_tooltip = true,
            icon = "widgets/keyboard/keyboard.png",
            layout = {
                edge = 'top',
                alignment = 'right',
                index = 5,
            },
        },
    }

    return widgets
end

return module

