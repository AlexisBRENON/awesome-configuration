local applications = {}

applications.terminal = {
    cmd = 'urxvt',
    matching = {
        class = {'URxvt'},
    }
}
applications.text_editor = {
    cmd = config.applications.terminal.cmd .. ' -e vim',
    matching = {
        name = {'vim'},
    }
}
applications.web_browser = {
    cmd = 'google-chrome-stable',
    match = {
        class = {'Google%-chrome%-stable'},
    }
}
applications.image_editor = {
    match = {
        class = {'Gimp'},
    }
}
applications.player = {
    match = {
        class = {'Vlc'},
    }
}
applications.office_text = {
    match = {
        class = {'libreoffice%-writer'},
    }
}
applications.office_slide = {
    match = {
        class = {'libreoffice%-impress'},
    }
}
applications.screensaver = {
    cmd = 'xscreensaver-command --activate',
}

return applications

