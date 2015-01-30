local log = require("utils/log")
local shifty = require('shifty')

local module = {}

function module.build(rules_config)
    log.info("Building windows rules")
    shifty.config.apps = rules_config
end

return module
