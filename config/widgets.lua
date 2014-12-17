local widgets = {
    -- Start with common widgets
    wibox = {},
    systray = {},
    promptbox = {},
    taglist = {},
    layoutbox = {},
    -- Then declare custom ones
    date_time = {
        update_time = 61,
        format = "%a %d/%m, %H:%M",
    },
    battery = {
        update_time = 59,
        device = "BAT0",
    },
    volume = {
        update_time = 3631,
        device = "alsa_output.pci-0000_00_1b.0.analog-stereo",
    },
    separator = {
        text = "  ",
    },
}

return widgets

