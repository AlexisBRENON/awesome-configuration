-- Make sure that there's always a client with focus
-- (on tag changement and client unmanagement)
require("awful.autofocus")
local awful = require("awful")


-- Create cache directory
os.execute("[ -d " .. awful.util.getdir("cache") .." ] || mkdir -p " .. awful.util.getdir("cache"))


-- Define main configuration variables
modkey = "Mod4"
config = {}
config.application = {
    ["terminal"] = {
        ["bin"] = "urxvtc",
        ["class"] = "URxvt",
    },
    ["file_browser"] = {
        ["bin"] = "gnome-commander",
        ["class"] = "Gnome-commander",
    },
    ["web_browser"] = {
        ["bin"] = "google-chrome",
        ["class"] = "Google-chrome",
    },
}
config.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.magnifier,
}
config.hostname = awful.util.pread('uname -n'):gsub('\n', '')


-- Remaining modules
require("mod/wallpaper")    -- Automatic wallpaper randomizer
require("mod/errors")       -- errors and debug stuff
require("mod/appearance")   -- theme and appearance settings
require("mod/autostart")    -- programs to run at login
require("mod/widgets")      -- widgets & wibox configuration
require("mod/bindings")     -- keybindings and mouse bindings


loadrc("tags")       -- tags handling
-- loadrc("xlock")         -- lock screen
loadrc("signals")    -- window manager behaviour
loadrc("rules")         -- window rules
-- loadrc("quake")         -- quake console
-- loadrc("xrandr")     -- xrandr menu

root.keys(config.keys.global)
