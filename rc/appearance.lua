gears = require("gears")

-- Theme
beautiful.init(awful.util.getdir("config") .. "/rc/theme.lua")
for s = 1, screen.count() do
	gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

-- Set cursor theme
os.execute("xsetroot -cursor_name left_ptr")
