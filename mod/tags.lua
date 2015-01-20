local shifty = require("shifty")
local beautiful = require("beautiful")
local awful = require("awful")


shifty.config.tags = {}

-- Init (without any name)
shifty.config.tags["\n"] = {
  position = 0,
  init = true,
}

-- Web browser
shifty.config.tags[""] = {
  position = 1,
}

-- File browser
shifty.config.tags[""] = {
  position = 2,
}

-- Sublime text / code
shifty.config.tags[""] = {
  position = 3,
}

-- Gimp / image management
shifty.config.tags[""] = {
  position = 4,
}

-- VLC / video
shifty.config.tags[""] = {
  position = 5,
}

-- Office calc
shifty.config.tags[""] = {
  position = 6,
}
-- Office writer
shifty.config.tags[""] = {
  position = 6,
}
-- Office impress
shifty.config.tags[""] = {
  position = 6,
}

-- IRC
shifty.config.tags["\239\130\134"] = {
    position = 9,
}

-- Teamviewer
shifty.config.tags[""] = {
  position = 9,
}


shifty.config.defaults = {
  layout = awful.layout.layouts[1],
  persist = false,
  floatBars = true,
  guess_name = true,
  guess_position = true,
  exclusive = true,
}
