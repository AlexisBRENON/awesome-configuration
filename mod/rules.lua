local shifty = require("shifty")

shifty.config.apps = {
    {
        match = {
            config.application.file_browser.class
        },
        tag = "file",
    },
    {
        match = {""},
        buttons = config.mouse.client,
    }
}
