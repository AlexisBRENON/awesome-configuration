local log = require("utils/log")

local module = {}

function module.load(config)
    log.info("Loading windows rules configuration")
    local rules = {
        {
            match = {
                class = {
                    'Termite'
                },
            },
            tag = "",
        },
        {
            match = {
                class = {
                    'Google%-chrome%-stable'
                },
            },
            tag = "",
        },
        {
            match = {
                class = {
                    'Vim',
                },
            },
            tag = "",
        },
        {
            match = {
                class = {
                    'Gimp',
                },
            },
            tag = "",
        },
        {
            match = {
                class = {
                    'Vlc',
                },
            },
            tag = "",
        },
        {
            match = {
                class = {
                    "libreoffice%-writer",
                },
            },
            tag = "",
        },
        {
            match = {
                class = {
                    "libreoffice%-impress",
                },
            },
            tag = "",
        },
        {
            match = {
                class = {
                    "libreoffice%-calc",
                },
            },
            tag = "",
        },
        {
            match = {
                type = {
                    "dialog",
                    "splash",
                }
            },
            float = true,
            intrusive = true,
        },
    }

    return rules
end

return module

