local log = require("utils/log")

local rules = {}

function rules.load(config)
    log.info("Loading windows rules configuration")
    table.insert(rules, {
        match = {
            class = {
                'Termite'
            },
        },
        tag = "",
    })
    table.insert(rules, {
        match = {
            class = {
                'google%-chrome'
            },
        },
        tag = "",
    })
    table.insert(rules, {
        match = {
            class = {
                'Vim',
            },
        },
        tag = "",
    })
    table.insert(rules, {
        match = {
            class = {
                'Gimp',
            },
        },
        tag = "",
    })
    table.insert(rules, {
        match = {
            class = {
                'Vlc',
            },
        },
        tag = "",
    })
    table.insert(rules, {
        match = {
            class = {
                "libreoffice%-writer",
            },
        },
        tag = "",
    })
    table.insert(rules, {
        match = {
            class = {
                "libreoffice%-impress",
            },
        },
        tag = "",
    })
    table.insert(rules, {
        match = {
            class = {
                "libreoffice%-calc",
            },
        },
        tag = "",
    })
    table.insert(rules, {
        match = {
            type = {
                "dialog",
                "splash",
            }
        },
        float = true,
        intrusive = true,
    })

    rules.load = nil
    return rules
end

return rules

