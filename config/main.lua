local log = require("utils/log")
local awful_wrapper = require('backend/awesome_wrapper/awful')

local main = {}

function main.load(config)
    log.info("Loading misc configuration")
    main.modkey = 'Mod4'
    main.config = awful_wrapper.getdir('config')
    main.cache = awful_wrapper.getdir('cache')
    main.builder = awful_wrapper.getdir('config') .. '/builder/'
    main.hostname = awful_wrapper.get_hostname()

    main.load = nil
    return main
end

return main

