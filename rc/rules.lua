awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
		    border_color = beautiful.border_normal,
		    focus = true,
		    maximized_vertical   = false,
		    maximized_horizontal = false,
		    keys = config.keys.client,
		    buttons = config.mouse.client }},
   -- Emacs
   { rule = { class = "Emacs" },
     properties = { tag = config.tags.emacs }},
   -- Browser stuff
   { rule = { name = "Iceweasel" },
     properties = { tag = config.tags.www }},
   { rule = { name = "Firefox" },
     properties = { tag = config.tags.www }},
   { rule = { name = "Chromium" },
     properties = { tag = config.tags.www }},
   { rule = { instance = "plugin-container" },
     properties = { floating = true }}, -- Flash with Firefox
   { rule = { instance = "exe", class="Exe", instance="exe" },
     properties = { floating = true }}, -- Flash with Chromium
   -- Pidgin
   { rule = { class = "Pidgin" },
     properties = { tag = config.tags.im }},
   { rule = { class = "Pidgin" },
     except = { role = "buddy_list" }, -- buddy_list is the master
     properties = { }, callback = awful.client.setslave },
   -- Other stuff
   { rule = { class = "URxvt" },
     properties = { }, callback = awful.client.setslave },
}
