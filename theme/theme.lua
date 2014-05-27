local awful = require("awful")

local na = awful.util.color_strip_alpha
local icons = awful.util.getdir("config") .. "theme/icons/"

theme = {}


-- Define common stuff
theme.icons 	= icons
theme.wallpaper = config.wallpaper
theme.font 		= "DejaVu Sans 8"


-- Define color scheme
theme.bg_normal     = "#2c3e50" -- Dark blue
theme.bg_focus      = "#ffffff" -- White
theme.bg_urgent     = "#00a3e6" -- Light blue

theme.fg_normal     = theme.bg_focus
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_focus

theme.border_width  = 2
theme.border_normal = "#3F3F3F" -- Dark grey
theme.border_focus  = "#6F6F6F" -- Light grey
theme.border_marked = "#93B0CD" -- Very light blue


-- Widget stuff
theme.widget_alternative_bg = theme.bg_focus
theme.widget_alternative_fg = theme.fg_focus


-- Taglist
theme.taglist_squares_sel   = icons .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = icons .. "/taglist/squarew.png"
for _, tag_name in pairs({"home", "web", "file", "gimp", "vlc"}) do
	theme["taglist_" .. tag_name] = icons .. "/taglist/" .. tag_name .. ".png"
end

-- Layout icons
for _, l in pairs(config.layouts) do
  theme["layout_" .. l.name] = icons .. "/layouts/" .. l.name .. ".png"
end


-- Naughty
local naughty = require("naughty")
naughty.config.presets.normal.bg = theme.bg_widget
for _,preset in pairs({"normal", "low", "critical"}) do
  naughty.config.presets[preset].font = "DejaVu Sans 10"
end


return theme
