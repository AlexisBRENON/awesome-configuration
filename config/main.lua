local log = require("utils/log")
local awful_wrapper = require('backend/awful_wrapper')

local module = {}

function module.load(config)
    log.info("Loading misc configuration")
    local main = {
        modkey = 'Mod4',
        config = awful_wrapper.getdir('config'),
        cache = awful_wrapper.getdir('cache'),
        hostname = awful_wrapper.get_hostname(),
    }
    return main
end

return module

