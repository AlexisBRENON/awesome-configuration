local log = require("utils/log")
local converter = require('utils/converter')
local shifty = require('shifty')

local module = {}

function module.build(keys_config)
    log.info("Building key bindings")
    local bindings = converter.create_keys(keys_config.global)
    root.keys(bindings)

    bindings = converter.create_keys(keys_config.client)
    shifty.config.clientkeys = bindings
end

return module
