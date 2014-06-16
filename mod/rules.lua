local shifty = require("shifty")

shifty.config.apps = {
    {
        match = {
            config.application.web_browser.class
        },
        tag = "🌐",
    },
    {
        match = {
            config.application.file_browser.class
        },
        tag = "📁",
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
        tag = "gimp",
    },
    {
        match = {
            "Vlc"
        },
        tag = "vlc",
    },
    {
        match = {
            "Subl"
        },
        tag = "subl",
    },
    {
        match = {
            "TeamViewer%.exe"
        },
        tag = "teamviewer"
    },
    {
        match = {
            "libreoffice.*"
        },
        tag = "office",
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
