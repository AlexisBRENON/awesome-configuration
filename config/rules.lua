local log = require("utils/log")

local module = {}

function module.load(config)
    log.info("Loading windows rules configuration")
    local rules = {
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
                name = {
                    'vim',
                },
            },
            tag = "",
        },
        {
            match = {
                class = {
                    'URxvt'
                },
            },
            honorsizehints = false,
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

