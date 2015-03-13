local log = require("utils/log")
local awful_wrapper = require('backend/awesome_wrapper/awful')

local module = {}

function module.load(config)
    log.info("Loading misc configuration")
    local main = {
        modkey = 'Mod4',
        config = awful_wrapper.getdir('config'),
        cache = awful_wrapper.getdir('cache'),
        builder = awful_wrapper.getdir('config') .. '/builder/',
        hostname = awful_wrapper.get_hostname(),
    }
    return main
end

return module

