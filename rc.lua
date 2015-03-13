local lfs = require("lfs")
local log = require("utils/log")
local config = require('config')
local builder = require('builder')

log.level = log.levels.ALL
log.info("Awesome config starts")
config_table = config.load()

local home_dir = lfs.currentdir()
lfs.chdir(config_table.main.config)
builder.build(config_table)
lfs.chdir(home_dir)
log.info("Awesome config ends")
