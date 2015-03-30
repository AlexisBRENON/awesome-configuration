local awful = require('awful')
local shifty = require('shifty')

local tag_wrapper = {}

function tag_wrapper.focus_client(relative_idx)
    awful.client.focus.byidx(relative_idx)
    if client.focus then
        client.focus:raise()
    end
end

tag_wrapper.rename = shifty.rename
tag_wrapper.add = shifty.add
tag_wrapper.delete = shifty.del
tag_wrapper.send_to_prev = shifty.send_prev
tag_wrapper.send_to_next = shifty.send_next
tag_wrapper.viewonly = awful.tag.viewonly
tag_wrapper.viewtoggle = awful.tag.viewtoggle

function tag_wrapper.change_master_size(direction)
    awful.tag.incmwfact(direction*0.05)
end

function tag_wrapper.change_layout(relative_idx)
    awful.layout.inc(awful.layout.layouts, relative_idx, mouse.screen)
end

return tag_wrapper
