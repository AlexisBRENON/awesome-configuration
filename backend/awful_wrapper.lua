local awful = require('awful')

local awful_wrapper = {}


function awful_wrapper.spawn(cmd)
    awful.util.spawn(cmd)
end

function awful_wrapper.screen_focus(relative_idx)
    awful.screen.focus_relative(relative_idx)
end

function awful_wrapper.restart_awesome()
    awful.util.restart()
end

function awful_wrapper.quit_aweesome()
    awesome.quit()
end

function awful_wrapper.change_tag(relative_idx)
    awful.tag.viewidx(relative_idx)
end

return awful_wrapper
