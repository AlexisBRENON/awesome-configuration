local lfs = require("lfs")
local log = require("utils/log")
local config = require('config')
local builder = require('builder')

log.level = log.levels.ALL
local home_dir = lfs.currentdir()
lfs.chdir(".config/awesome")
log.info("Awesome config starts")
config_table = config.load()
builder.build(config_table)
lfs.chdir(home_dir)
log.info("Awesome config ends")
