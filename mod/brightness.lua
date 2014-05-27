-- Handle brightness (with xbacklight)

local brightness = {}

local awful = require("awful")
local naughty = require("naughty")

local nid = nil
function brightness.change(what)
    -- We don't really change the brightness, just report the change...
    local out = awful.util.pread("xbacklight -get")
    if not out then return end

    nid = naughty.notify({
        text = out .. " %",
        replaces_id = nid }).id
end

return brightness