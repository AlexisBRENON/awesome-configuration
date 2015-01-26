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
        ---[[
        promptbox = {
            layout = {
                edge = 'top',
                alignment = 'left',
                index = 100, -- right most
            }
        },
        taglist = {
            layout = {
                edge = 'top',
                alignment = 'left',
                index = 50,
            }
        },
        layoutbox = {
            layout = {
                edge = 'top',
                alignment = 'left',
                index = 0, -- Left most widget
            }
        },
        systray = {
            screen = '1', -- Only on screen 1
            layout = {
                edge = 'top', -- Add it to the top wibox
                alignment = 'right', -- On the right
                index = 0, -- Left most
            },
        },
        -- Then declare custom ones
        datetime = {
            has_text = true,
            update_time = 61,
            format = "%a %d/%m, %H:%M",
            layout = {
                edge = 'top', -- Add it to the top wibox
                alignment = 'right', -- On the right
                index = 100, -- Right most
            },
        },
        battery = {
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
        volume = {
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
        --]]
    }

    return widgets
end

return module

