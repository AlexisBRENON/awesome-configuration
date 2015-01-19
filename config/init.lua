local module = {}

function module.load()
    local config = {}

    -------------------------------------------------------------------------------------
    -- Define some very common things (modket, pathes, etc...)
    config.main = require('config/main').load(config)

    -------------------------------------------------------------------------------------
    -- Define common applications, their command for ones launchable via keyboard shortcut
    -- and the match dictionary for the (shifty) rules
    config.applications = require('config/applications').load(config)

    -------------------------------------------------------------------------------------
    -- Define keys binding and shortcuts
    config.keys = require('config/keys').load(config)
    config.mouse = require('config/mouse').load(config)

    -------------------------------------------------------------------------------------
    -- Define different keyboard layouts allowed
    config.keyboard = require('config/keyboard').load(config)

    -------------------------------------------------------------------------------------
    -- Define tags
    config.tags = require('config/tags').load(config)

    -------------------------------------------------------------------------------------
    -- Define matching rules
    config.tags = require('config/rules').load(config)

    -------------------------------------------------------------------------------------
    -- Define widgets
    config.widgets = require('config/widgets').load(config)

    return config
end

return module

