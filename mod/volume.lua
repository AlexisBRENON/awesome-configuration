local awful        = require("awful")
local naughty      = require("naughty")
local vicious = require("vicious")

local volume = {}

local function change(device, what)
    os.execute("amixer -q sset " .. device .. " " .. what, false)
    vicious.force({config.widgets.volume.widget}) -- Update the volume widget
end

local function increase(device)
    change(device, "5%+")
end

local function decrease(device)
    change(device, "5%-")
end

local function toggle(device)
    change(device, "toggle")
end

-- run pavucontrol
local function mixer(device)
    awful.util.spawn("pavucontrol", false)
end


-- Define public interface
volume.increase = increase
volume.decrease = decrease
volume.toggle = toggle
volume.mixer = mixer

return volume
