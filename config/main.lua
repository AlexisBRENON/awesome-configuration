local awful_wrapper = require('backend/awful_wrapper')

local module = {}

function module.load(config)
    local main = {
        modkey = 'Mod4',
        config = awful_wrapper.getdir('config'),
        cache = awful_wrapper.getdir('cache'),
        hostname = awful_wrapper.get_hostname(),
--        theme = awful_wrapper.getdir('config') .. "/theme/theme.lua",
    }
    return main
end

return module

