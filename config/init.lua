local awful = require('awful')

local config = {}

config.main = require('config/main')

-------------------------------------------------------------------------------------
-- Define common applications, their command for ones launchable via keyboard shortcut
-- and the match dictionary for the (shifty) rules
config.applications = require('config/applications')

-------------------------------------------------------------------------------------
-- Define keys binding and shortcuts

config.keys = require('config/keys')
config.mouse = require('config/mouse')

-------------------------------------------------------------------------------------
-- Define different keyboard layouts allowed

config.keyboard_layouts = {
    -- {layout, variant, displayed name}
    {"fr", "oss", "Français"}, -- Alternative french AZERTY
    {"us", "dvp", "Dvorak Programmeur"}, -- Dvorak for programmers
}

-------------------------------------------------------------------------------------
-- Define tags

local tags = require('config/tags')
config.tags = {}
config.tags.tags = tags.tags
config.tags.defaults = tags.defaults

-------------------------------------------------------------------------------------
-- Define widgets

config.widgets = require('config/widgets')



