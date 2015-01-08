local widgets = {
    -- Start with common widgets
    wibox = {
        top = {}, -- I want a wibox on top
        bottom = nil, -- No wibox at bottom
        left = nil,
        right = nil,
    },
    promptbox = {},
    taglist = {},
    layoutbox = {},
    systray = {
        layout = {
            wibox = 'top', -- Add it to the top wibox
            layout = {
                position = 'right', -- On the right
                index = 100, -- Left most of the right
            },
            screen = '1', -- Only on screen 1
        },
    },
    -- Then declare custom ones
    date_time = {
        update_time = 61,
        format = "%a %d/%m, %H:%M",
        layout = {
            wibox = 'top', -- Add it to the top wibox
            layout = {
                position = 'right', -- On the right
                index = 00, -- Right most of the right
            },
            screen = nil, -- On every screen
        },
    },
    battery = {
        update_time = 59,
        device = "BAT0",
        layout = {
            wibox = 'top', -- Add it to the top wibox
            layout = {
                position = 'right', -- On the right
                index = 30, 
            },
            screen = nil, -- On every screen
        },
    },
    volume = {
        update_time = 3631,
        device = "alsa_output.pci-0000_00_1b.0.analog-stereo",
        layout = {
            wibox = 'top', -- Add it to the top wibox
            layout = {
                position = 'right', -- On the right
                index = 10, 
            },
            screen = 1,
        },
    },
}

return widgets

