local log = require("utils/log")
-- Awesome wrappers
local awful_wrapper = require('backend/awesome_wrapper/awful')
local tag_wrapper = require('backend/awesome_wrapper/tag')
local client_wrapper = require('backend/awesome_wrapper/client')
-- Custom backend
local brightness = require('backend/brightness')
local keyboard = require('backend/keyboard')
local prompt = require('backend/prompt')
local screenshot = require('backend/screenshot')
local volume = require('backend/volume')
local wlan = require('backend/wlan')
local xrandr = require('backend/xrandr')

local keys = {}

function keys.load(config)
    log.info("Loading key bindings configuration")
    local modkey = config.main.modkey
    keys.global = {
        -- {{ modkeys        }, key, press, release, description},
        -- Disable/Enable WLAN networks
        {{                   }, "XF86WLAN", wlan.toggle, nil, "Toggle wifi"},
        -- Full screen shot
        {{                   }, "Print", screenshot.full, nil, "Screenshot"},
        -- Calculator prompt
        {{ modkey            }, "F1", prompt.calculator, nil, "Calculator prompt"},
        -- Default prompt
        {{ modkey            }, "F2", prompt.execute, nil, "Classic prompt"},
        -- Web search prompt
        {{ modkey            }, "F12", prompt.web_search, nil, "Web search prompt"},
        -- Focus previously focused window
        {{ modkey,           }, "Tab", function() tag_wrapper.focus_client(-1) end, nil, "Focus previous window"},
        -- Start the text editor
        {{ modkey,           }, "e", function () awful_wrapper.spawn(config.applications.text_editor) end, nil, "Launch text editor"},
        -- Rename the current tag
        {{ modkey            }, "r", tag_wrapper.rename, nil, "Rename current tag"},
        -- Create a new tag
        {{ modkey            }, "t", tag_wrapper.add, nil, "Create new tag"},
        -- Spawn a web browser
        {{ modkey,           }, "o", function () awful_wrapper.spawn(config.applications.web_browser) end, nil, "Launch web browser"},
        -- Decrease master-width factor
        {{ modkey,           }, "h", function () tag_wrapper.change_master_size(-1) end, nil, "Reduce master size"},
        -- Focus next window
        {{ modkey,           }, "j", function () tag_wrapper.focus_client(1) end, nil, "Focus next window"},
        -- Increase master-width factor
        {{ modkey,           }, "l", function () tag_wrapper.change_master_size(1) end, nil, "Increase master size"},
        -- Spawn a terminal
        {{ modkey,           }, "Return", function () awful_wrapper.spawn(config.applications.terminal) end, nil, "Launch terminal"},
        -- Delete the current tag
        {{ modkey            }, "w", tag_wrapper.del, nil, "Delete tag"}, -- delete a tag
        -- Next layout
        {{ modkey,           }, "Up", function () tag_wrapper.change_layout(1) end, nil, "Next layout"},
        -- Show previous tag
        {{ modkey            }, "Left", function() awful_wrapper.change_tag(-1) end, nil, "Go to next tag"},
        -- Previous layout
        {{ modkey,           }, "Down", function () tag_wrapper.change_layout(-1) end, nil, "Previous layout"},
        -- Show next tag
        {{ modkey            }, "Right", function() awful_wrapper.change_tag(1) end, nil, "Go to next tag"},
        -- Restart awesome
        {{ modkey, "Control" }, "r", awful_wrapper.restart_awesome, nil, "Restart awesome"},
        -- Quit awesome
        {{ modkey, "Control" }, "q", awful_wrapper.quit_awesome, nil, "Quit awesome"},
        -- Jump to next screen
        {{ modkey, "Control" }, "j", function () awful_wrapper.screen_focus(1) end, nil, "Jump to next screen"},
        -- Jump to previous screen
        {{ modkey, "Control" }, "k", function () awful_wrapper.screen_focus(-1) end, nil, "Jump to previous screen"},
        -- Activate screensaver
        {{ modkey, "Control" }, "space", function () awful_wrapper.spawn(config.applications.screensaver) end, nil, "Start screensaver"},
        -- Toggle volume
        {{ modkey, "Shift"   }, "F1", volume.toggle, nil, "(Un)Mute volume"},
        -- Decrease volume
        {{ modkey, "Shift"   }, "F2", volume.decrease, nil, "Decrease volume"},
        -- Increase volume
        {{ modkey, "Shift"   }, "F3", volume.increase, nil, "Increase volume"},
        -- Switch between screens configurations
        {{ modkey, "Shift"   }, "F7", xrandr.change_screen, nil, "Switch between screens configurations"},
        -- Increase screen backlight
        {{ modkey, "Shift"   }, "F12", brightness.increase, nil, "Increase brightness"},
        -- Decrease screen backlight
        {{ modkey, "Shift"   }, "F11", brightness.decrease, nil, "Decrease brightness"},
        -- Change keyboard layout
        {{ modkey, "Shift"   }, "space", keyboard.change_layout, nil, "Change keyboard layout"},
        -- -- Send client to prev tag
        {{ modkey, "Shift"   }, "Left", tag_wrapper.send_to_prev, nil, "Send window to previous tag"},
        -- Send client to next tag
        {{ modkey, "Shift"   }, "Right", tag_wrapper.send_to_next, nil, "Send window to next tag"},
        -- Selection screenshot
        {{         "Shift"   }, "Print", screenshot.selection, nil, "Screenshot selection"},
        -- Move tag to left
        {{ modkey, "Shift", "Control"}, "Left", function() tag_wrapper.move_tag(-1) end, nil, "Move tag to left"},
        -- Move tag to right
        {{ modkey, "Shift", "Control"}, "Right", function() tag_wrapper.move_tag(1) end, nil, "Move tag to right"},
    }

    keys.client = {
        -- Stick window
        {{ modkey,           }, "s", client_wrapper.sticky, nil, "Make window sticky"},
        -- Fullscreen
        {{ modkey,           }, "f", client_wrapper.fullscreen, nil, "Make window fullscreen"},
        -- Maximize the current window
        {{ modkey,           }, "m", client_wrapper.maximize, nil, "Maximize window"},
        -- Close
        {{ modkey,           }, "x", client_wrapper.kill, nil, "Close window"},
        -- Switch with master window
        {{ modkey, "Control" }, "Return", client_wrapper.switch_master, nil, "Switch window with master"},
        -- Window
        {{ "Control" }, "Print", screenshot.window, nil, "Window screen shot"}
    }

    keys.load = nil
    return keys
end

return keys

