local naughty = require("naughty")
local beautiful = require("beautiful")

local keyboard = {}

local keyboard_layouts = {
  {"fr", "oss", "Français"}, -- Alternative french AZERTY
  {"us", "dvp", "Dvorak Programmeur"}, -- Dvorak for programmers
}
local current_layout = 1
local notification_id = nil

local function fix_layout()
  os.execute("xmodmap -e 'keycode 248 = XF86WLAN NoSymbol XF86WLAN'")
end

local function change_layout()
  current_layout = (current_layout % #keyboard_layouts) + 1
  new_layout = keyboard_layouts[current_layout]
  os.execute("setxkbmap -layout " .. new_layout[1] .. " -variant " .. new_layout[2])
  fix_layout()
  config.widgets.keyboard.tooltip:set_text(new_layout[3])
  notification_id = naughty.notify({
    text = new_layout[3],
    icon = beautiful.icons .. "/widgets/keyboard/keyboard.png",
    icon_size = config.widgets.wiboxes.top.size,
    replaces_id = notification_id,
    }).id
end

local function init()
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
  fix_layout()
  config.widgets.keyboard.tooltip:set_text(keyboard_layouts[current_layout][3])
end

keyboard.init = init
keyboard.change_layout = change_layout

return keyboard