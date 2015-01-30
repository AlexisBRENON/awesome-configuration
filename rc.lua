local log = require("utils/log")
local config = require('config')
local builder = require('builder')

log.level = log.levels.ALL
log.info("Awesome config starts")
builder.build(config.load())
log.info("Awesome config ends")
