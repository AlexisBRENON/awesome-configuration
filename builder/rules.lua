local shifty = require('shifty')

local module = {}

function module.build(rules_config)
    shifty.config.apps = rules_config
end

return module
