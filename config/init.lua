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

config.keyboard = require('config/keyboard')

-------------------------------------------------------------------------------------
-- Define tags

config.tags = require('config/tags')

-------------------------------------------------------------------------------------
-- Define matching rules

config.tags = require('config/rules')

-------------------------------------------------------------------------------------
-- Define widgets

config.widgets = require('config/widgets')

return config
