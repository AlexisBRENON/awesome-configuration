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
        tag = "",
        run = function (args)
            local clients = client.get(mouse.screen)
            local client = nil
            print(os.date("%m-%d_%H-%M-%S"))
            print(args)
            for j, p in ipairs({"name", "class", "instance"}) do
                print("    " .. p .. " : " .. (args[p] or "nil"))
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
