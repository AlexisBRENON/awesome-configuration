local awful = require('awful')

local client_wrapper = {}

function client_wrapper.stick(c)
    c.sticky = not c.sticky
end

function client_wrapper.fullscreen(c)
    c.fullscreen = not c.fullscreen
end

function client_wrapper.kill(c)
    c:kill()
end

function client_wrapper.switch_master(c)
    c:swap(awful.client.getmaster())
end

function client_wrapper.move_to_screen(c, relative_idx)
    awful.client.movetoscreen(c, awful.util.cycle(screen.count(), c.screen-relative_idx))
end

function client_wrapper.focus(c)
    client.focus = c
    c:raise()
end

client_wrapper.move = awful.mouse.client.move
client_wrapper.resize = awful.mouse.client.resize

return client_wrapper

