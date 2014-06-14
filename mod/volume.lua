local awful        = require("awful")
local naughty      = require("naughty")

local volume = {}

local notification_id = nil
local function change(what)
    os.execute("amixer -q sset Master " .. what, false)
    -- Read the current value
    local out = awful.util.pread("amixer sget Master")
    local vol, mute = out:match("([%d]+)%%.*%[([%l]*)")
    if not mute or not vol then return end

    vol = tonumber(vol)
    local icon = "high"
    if mute ~= "on" or vol == 0 then
        icon = "muted"
    elseif vol < 30 then
        icon = "low"
    elseif vol < 60 then
        icon = "medium"
    end

    volid = naughty.notify({
        text = string.format("%3d %%", vol),
	    icon = awful.util.geticonpath("audio-volume-" .. icon),
	    replaces_id = volid }).id
end

local function increase()
    change("5%+")
end

local function decrease()
    change("5%-")
end

local function toggle()
    change("toggle")
end

-- run pavucontrol
local function mixer()
    awful.util.spawn("pavucontrol", false)
end


-- Define public interface
volume.increase = increase
volume.decrease = decrease
volume.toggle = toggle
volume.mixer = mixer

return volume
