local log = require("utils/log")
local tag_wrapper = require("backend/awesome_wrapper/tag")
local client_wrapper = require("backend/awesome_wrapper/client")
local datetime = require("backend/datetime")
local volume = require("backend/volume")

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
            type = "textbox",
            value = "  ",
            layout = {
                edge = 'top',
                alignment = 'left',
                index = 99,
            },
        },
        {
            type = "taglist",
            layout = {
                edge = 'top',
                alignment = 'left',
                index = 50,
            },
            buttons = {
                {{}, 1, tag_wrapper.viewonly, nil, "Display only one tag"},
                {{config.main.modkey}, 1, client_wrapper.move_to_tag, nil, "Move client to a tag"},
                {{}, 3, tag_wrapper.viewtoggle, nil, "Toggle a tag"},
            },
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
            buttons = {
                { {}, 4, "decrease", nil}, -- scroll
                { {}, 5, "increase", nil}, -- scroll
                { {}, 3, "toggle", nil }, -- right click
                { {}, 1, "mixer", nil }, -- left click
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
            icon = config.theme.icons .. "/widgets/keyboard/keyboard.png",
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

