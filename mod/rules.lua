local shifty = require("shifty")

shifty.config.apps = {
    {
        match = {
            config.application.web_browser.class
        },
        tag = "",
    },
    {
        match = {
            config.application.file_browser.class
        },
        tag = "",
    },
    {
        match = {
            config.application.terminal.class
        },
        slave = true,
    },
    {
        match = {
            "Gimp.*"
        },
        tag = "",
    },
    {
        match = {
            "Vlc"
        },
        tag = "",
    },
    {
        match = {
            "Subl"
        },
        tag = "",
    },
    {
        match = {
            "TeamViewer%.exe"
        },
        tag = ""
    },
    {
        match = {
            "libreoffice%-writer"
        },
        tag = "",
    },
    {
        match = {
            "libreoffice%-impress"
        },
        tag = "",
    },
    {
        match = {
            "libreoffice%-calc"
        },
        tag = "",
    },
    {
        match = {
            "_NET_WM_WINDOW_TYPE_DIALOG",
            "_NET_WM_WINDOW_TYPE_SPLASH",
        },
        float = true,
        intrusive = true,
    },
    {
        match = {""},
        buttons = config.mouse.client,
    }
}
