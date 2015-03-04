local log = require("utils/log")
local config = require('config')
local builder = require('builder')

log.level = log.levels.ALL
log.info("Awesome config starts")
config_table = config.load()
require("lfs").chdir(config_table.main.config)
builder.build(config_table)
log.info("Awesome config ends")
