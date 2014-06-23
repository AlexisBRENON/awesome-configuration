local shifty = require("shifty")
local awful = {}
awful.util = require("awful.util")

shifty.config.apps = {
    {
        match = {
            config.application.web_browser.matching
        },
        tag = "",
    },
    {
        match = {
            config.application.file_browser.matching
        },
        tag = "",
    },
    {
        match = {
            config.application.terminal.matching
        },
        slave = true,
    },
    {
        match = {
            config.application.image_editor.matching
        },
        tag = "",
    },
    {
        match = {
            config.application.video_player.matching
        },
        tag = "",
    },
    {
        match = {
            config.application.text_editor.matching
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
        tag = "",
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
            class = {"LibreOffice.*"},
            name = {}
        },
        tag = "",
        run = function ()
            print("screen : " .. mouse.screen+1 .. " mod(" .. screen.count() .. ") = " .. awful.util.cycle(screen.count(), mouse.screen+1))
        end,
        screen = awful.util.cycle(screen.count(), mouse.screen+1)
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
