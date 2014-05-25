require("beautiful")
require("awful")

-- Load theme
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")
-- Link it to awful
awful.beautiful.register(beautiful)

-- Set cursor theme
os.execute("xsetroot -cursor_name left_ptr")
