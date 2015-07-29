local log = require("utils/log")

local applications = {}

function applications.load()
    log.info("Loading default applications configuration")
    applications.terminal = 'termite'
    applications.text_editor =  applications.terminal .. ' --exec=vim --role="Text Editor" --name="vim" --class="Vim"'
    applications.web_browser = 'google-chrome-stable'
    applications.screensaver = 'xscreensaver-command --activate'
    applications.load = nil
    return applications
end

return applications

