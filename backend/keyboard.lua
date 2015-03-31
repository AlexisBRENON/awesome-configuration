local naughty = require("naughty")
local beautiful = require("beautiful")

local keyboard = {}

local current_layout = nil
local notification_id = nil
local widgets = {}

local function define_custom_keycodes()
    os.execute("xmodmap -e 'keycode 248 = XF86WLAN NoSymbol XF86WLAN'")
end

local function get_current_layout()
    -- Fetch in the configured layout the one matching the actual Xorg keyboard settings
    local setxkbmap = io.popen("setxkbmap -query | grep -e 'layout' -e 'variant'")
    local layout, variant
    if setxkbmap then
        layout = (setxkbmap:read()):match("^layout:%s*(%w*)$")
        variant = (setxkbmap:read()):match("^variant:%s*(%w*)$")
        setxkbmap:close()
    end
    if layout and variant then
        for i,v in ipairs(keyboard_layouts) do
            if v[1] == layout and v[2] == variant then
                current_layout = i
                break
            end
        end
        -- Check that we found a matching configuration
        if not current_layout then
            error("Unable to find a layout/variant pair matching : " .. layout .. "/" .. variant)
        end
    else
        error("Unable to get the layout/variant setting")
    end
end

local function notify()
    local layout_name = keyboard_layouts[current_layout][3]
    for _, widget in ipairs(widgets) do
        if widget.tooltip then widget.tooltip:set_text(layout_name) end
        notification_id = naughty.notify({
            text = layout_name,
            icon = beautiful.icons .. "/widgets/keyboard/keyboard.png",
            icon_size = 16, 
            replaces_id = notification_id,
        }).id
    end
end

local function change_layout()
    current_layout = (current_layout % #keyboard_layouts) + 1
    new_layout = keyboard_layouts[current_layout]
    os.execute("setxkbmap -layout " .. new_layout[1] .. " -variant " .. new_layout[2])
    define_custom_keycodes()
    notify()
end

local function add_widget(widget)
    table.insert(widgets, widget)
end

local function init(keyboard_config)
    keyboard_layouts = keyboard_config.layouts
    keyboard_custom_keys = keyboard_config.custom_keycodes
    get_current_layout()
    define_custom_keycodes()
    notify()
end

keyboard.add_widget = add_widget
keyboard.change_layout = change_layout
keyboard.init = init

return keyboard
