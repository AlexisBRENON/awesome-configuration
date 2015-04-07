local log = require("utils/log")

local module = {}

function module.load()
    log.info("Loading default applications configuration")
    local applications = {}
    applications.terminal = 'termite'
    applications.text_editor =  applications.terminal .. ' --exec=vim --role="Text Editor" --name="vim" --class="Vim"'
    applications.web_browser = 'google-chrome-stable'
    applications.screensaver = 'xscreensaver-command --activate'
    return applications
end

return module

