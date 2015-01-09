local awful = require("awful")

theme = {}

-- Define common stuff
theme.icons 	= awful.util.getdir("config") .. "/theme/icons/"
theme.wallpaper = config.wallpaper
theme.font 		= "DejaVu Sans 11"
theme.font_mono = "DejaVu Sans Mono 8"

-- Define color scheme
theme.bg_normal     = "#272822" -- Monokai black bg
theme.bg_focus      = "#3E3D32" -- Monokai grey highlight
theme.bg_urgent     = theme.bg_normal

theme.fg_normal     = "#F8F8F2" -- Monokai white fg
theme.fg_focus      = "#E6DB74" -- Monokai yellow
theme.fg_urgent     = "#F92672" -- Monokai red

theme.border_width  = 2
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_normal
theme.border_marked = theme.fg_focus


-- Systray
theme.bg_systray = theme.wallpaper
theme.systray_icon_spacing = 2


-- Taglist
theme.taglist_bg_empty = "#00000000" -- No background
theme.taglist_bg_occupied = theme.taglist_bg_empty
theme.taglist_bg_focus = theme.taglist_bg_empty
theme.taglist_bg_urgent = theme.taglist_bg_empty

theme.taglist_fg_empty = theme.fg_normal
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_fg_urgent = theme.fg_urgent

theme.taglist_font = "FontAwesome 12"

theme.taglist_squares_sel = theme.icons .. "taglist/none.png"
theme.taglist_squares_unsel = theme.icons .. "taglist/none.png"
theme.taglist_squares_sel_empty = theme.icons .. "taglist/none.png"
theme.taglist_squares_unsel_empty = theme.icons .. "taglist/none.png"
theme.taglist_squares_resize = "false"


-- Layout icons
for _, l in pairs(awful.layout.layouts) do
	theme["layout_" .. l.name] = theme.icons .. "layouts/" .. l.name .. ".png"
end

-- Naughty
local naughty = require("naughty")
naughty.config.presets.normal.bg = theme.bg_normal
naughty.config.presets.normal.fg = theme.fg_normal
naughty.config.presets.normal.border_color = theme.fg_normal

naughty.config.presets.low.bg = theme.bg_normal
naughty.config.presets.low.fg = theme.fg_normal
naughty.config.presets.low.border_color = theme.bg_normal

naughty.config.presets.critical.bg = theme.bg_urgent
naughty.config.presets.critical.fg = theme.fg_urgent
naughty.config.presets.critical.border_color = theme.fg_urgent


-- Tooltips
theme.tooltip_border_width = theme.border_width
theme.tooltip_border_color = theme.fg_normal
theme.tooltip_opacity = 0.9
theme.tooltip_fg_color = theme.fg_normal

return theme
