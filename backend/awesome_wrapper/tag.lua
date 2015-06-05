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
    awful.layout.inc(relative_idx, mouse.screen, awful.layout.layouts)
end

local function tag2index(screen, tag)
    for i, t in ipairs(awful.tag.gettags(screen)) do
        if t == tag then return i end
    end
end

function tag_wrapper.move_tag(relative_index)
    local current_screen = mouse.screen
    local current_screen_index = current_screen - 1
    local current_tag = awful.tag.selected(current_screen)
    local current_tag_index = tag2index(current_screen, current_tag)

    local new_screen = current_screen
    local new_screen_index = current_screen_index
    local new_tag_index = current_tag_index + relative_index

    -- Compute the new screen of the tag
    if new_tag_index < 1 then
        new_screen_index = current_screen_index - 1
    elseif new_tag_index > #awful.tag.gettags(current_screen) then
        new_screen_index = current_screen_index + 1
    end
    new_screen_index = new_screen_index % screen.count()
    new_screen = new_screen_index + 1

    -- Define new tag index depending on already existing tag on new screen
    if new_tag_index < 1 then
            new_tag_index = #awful.tag.gettags(new_screen)
        if new_screen ~= current_screen then
            new_tag_index = new_tag_index + 1
        end
    elseif new_tag_index > #awful.tag.gettags(current_screen) then
        new_tag_index = 1
    end

    -- Move tag to the new screen
    if new_screen ~= current_screen then
        awful.tag.setscreen(current_tag, new_screen)
        awful.tag.viewonly(current_tag)
        mouse.screen = new_screen
    end
    -- Move tag to the new index
    awful.tag.move(new_tag_index, current_tag)
end

return tag_wrapper
