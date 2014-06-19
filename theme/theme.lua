local awful = require("awful")

local na = awful.util.color_strip_alpha
local icons = awful.util.getdir("config") .. "/theme/icons/"

theme = {}


-- Define common stuff
theme.icons 	= icons
theme.wallpaper = config.wallpaper
theme.font 		= "DejaVu Sans 11"
theme.font_mono = "DejaVu Sans Mono 8"


-- Define color scheme
theme.bg_normal     = "#2c3e50" -- Dark blue
theme.bg_focus      = "#ffffff" -- White
theme.bg_urgent     = "#00a3e6" -- Light blue

theme.fg_normal     = theme.bg_focus
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal

theme.border_width  = 2
theme.border_normal = "#3F3F3F" -- Dark grey
theme.border_focus  = "#6F6F6F" -- Light grey
theme.border_marked = "#93B0CD" -- Very light blue


-- Widget stuff
theme.widget_alternative_bg = theme.bg_focus
theme.widget_alternative_fg = theme.fg_focus

-- Systray stuff
theme.bg_systray = theme.widget_alternative_bg
theme.systray_icon_spacing = 4


-- Taglist
-- Tag colors
theme.taglist_fg_empty = theme.widget_alternative_fg -- Dark blue over...
theme.taglist_bg_empty = theme.widget_alternative_bg -- white
theme.taglist_fg_occupied = theme.taglist_fg_empty -- Idem
theme.taglist_bg_occupied = theme.taglist_bg_empty
theme.taglist_fg_focus = theme.taglist_bg_empty -- White over...
theme.taglist_bg_focus = theme.taglist_fg_empty -- Dark blue
theme.taglist_fg_urgent = theme.fg_urgent -- Dark blue over...
theme.taglist_bg_urgent = theme.bg_urgent -- ... Light blue
theme.taglist_font = "FontAwesome 12"
-- Clients images
theme.taglist_squares_sel   = icons .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = icons .. "/taglist/squarew.png"
-- Tag icons
for _, tag_name in pairs({"home", "web", "file", "gimp", "vlc"}) do
	theme["taglist_" .. tag_name] = icons .. "/taglist/" .. tag_name .. ".png"
end

-- Layout icons
for _, l in pairs(awful.layout.layouts) do
  	theme["layout_" .. l.name] = icons .. "/layouts/" .. l.name .. ".png"
end


-- Naughty
local naughty = require("naughty")
naughty.config.presets.normal.bg = theme.bg_widget
for _,preset in pairs({"normal", "low", "critical"}) do
  naughty.config.presets[preset].font = "DejaVu Sans 10"
end


return theme
