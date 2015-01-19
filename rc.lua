local config = require('config')
local builder = require('builder')

builder.build(config.load())
