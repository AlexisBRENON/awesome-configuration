local module = {}

function module.load(config)
    local widgets = {
    -- Start with common widgets
    wibox = {
        top = {}, -- I want a wibox on top
        bottom = nil, -- No wibox at bottom
        left = nil,
        right = nil,
    },
    promptbox = {
        layout = {
            wibox = 'top',
            position = 'left',
            index = 100, -- right most on the left
        }
    },
    taglist = {
        layout = {
            wibox = 'top',
            position = 'left',
            index = 50,
        }
    },
    layoutbox = {
        layout = {
            wibox = 'top',
            position = 'left',
            index = 0, -- Left most widget
        }
    },
    systray = {
        screen = '1', -- Only on screen 1
        layout = {
            wibox = 'top', -- Add it to the top wibox
            position = 'right', -- On the right
            index = 100, -- Left most of the right
        },
    },
    separator = {
        type = 'text',
        value = '  ',
    },
    -- Then declare custom ones
    date_time = {
        update_time = 61,
        format = "%a %d/%m, %H:%M",
        layout = {
            wibox = 'top', -- Add it to the top wibox
            position = 'right', -- On the right
            index = 00, -- Right most of the right
        },
    },
    battery = {
        update_time = 59,
        device = "BAT0",
        layout = {
            wibox = 'top', -- Add it to the top wibox
            position = 'right', -- On the right
            index = 30, 
        },
    },
    volume = {
        update_time = 3631,
        device = "alsa_output.pci-0000_00_1b.0.analog-stereo",
        screen = 1,
        layout = {
            wibox = 'top', -- Add it to the top wibox
            position = 'right', -- On the right
            index = 10, 
        },
    },
}

return widgets
end

return module

