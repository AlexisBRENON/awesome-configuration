local naughty = require("naughty")
local beautiful = require("beautiful")

local keyboard = {}

local current_layout = 1
local notification_id = nil

local function define_custom_keycodes()
    os.execute("xmodmap -e 'keycode 248 = XF86WLAN NoSymbol XF86WLAN'")
end

local function get_current_layout()
    -- TODO : Check also that variant is equal
    local setxkbmap = io.popen("setxkbmap -query | grep layout")
    if setxkbmap then
        for line in setxkbmap:lines() do
            layout = line:match("^layout:%s*(%w*)$")
            if layout then
                for i,v in ipairs(keyboard_layouts) do
                    if v[1] == layout then
                        current_layout = i
                        break
                    end
                end
                break
            end
        end
        setxkbmap:close()
    end
end

local function notify()
    local layout_name = keyboard_layouts[current_layout][3]
    if tooltip then tooltip:set_text(layout_name) end
    notification_id = naughty.notify({
        text = layout_name,
        icon = beautiful.icons .. "/widgets/keyboard/keyboard.png",
        icon_size = 16, 
        replaces_id = notification_id,
    }).id
end

local function change_layout()
    current_layout = (current_layout % #keyboard_layouts) + 1
    new_layout = keyboard_layouts[current_layout]
    os.execute("setxkbmap -layout " .. new_layout[1] .. " -variant " .. new_layout[2])
    define_custom_keycodes()
    notify()
end

local function init(keyboard_config)
    keyboard_layouts = keyboard_config.layouts
    keyboard_custom_keys = keyboard_config.custom_keycodes
    get_current_layout()
    define_custom_keycodes()
end

keyboard.change_layout = change_layout
keyboard.init = init

return keyboard
