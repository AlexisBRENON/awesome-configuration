local shifty = require("shifty")
local awful = require("awful")

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
            name = {nil}
        },
        run = function (client)
            if client.name == nil then
                print(os.date("%m-%d_%H-%M-%S") .. " match")
                awful.client.movetotag(shifty.add({
                    name = "",
                    screen = 2
                    }), client)
            else
                print(os.date("%m-%d_%H-%M-%S") .. " " .. client.name .. " match")
                awful.client.movetotag(shifty.add({
                    name = "slideshow",
                    screen = 1,
                    }), client)
            end
        end,
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
