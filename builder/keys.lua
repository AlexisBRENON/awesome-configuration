local log = require("utils/log")
local awful = require('awful')
local shifty = require('shifty')

local module = {}

function module.build(keys_config)
    log.info("Building key bindings")
    local bindings = {}
    for _, binding in ipairs(keys_config.global) do
        bindings = awful.util.table.join(
        bindings,
        awful.key(binding[1], binding[2], binding[3], binding[4])
        )
        -- TODO : add support of the description
    end
    root.keys(bindings)

    bindings = {}
    for _, binding in ipairs(keys_config.client) do
        bindings = awful.util.table.join(
        bindings,
        awful.key(binding[1], binding[2], binding[3], binding[4])
        )
        -- TODO : add support of the description
    end
    shifty.config.clientkeys = bindings
end

return module
