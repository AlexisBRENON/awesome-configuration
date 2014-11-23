local awful        = require("awful")
local naughty      = require("naughty")
local vicious = require("vicious")
vicious.contrib = {
    pulse = require("vicious/contrib/pulse")
}

local volume = {}

local function change(device, what)
    os.execute("amixer -q sset " .. device .. " " .. what, false)
    vicious.force({config.widgets.volume.widget}) -- Update the volume widget
end

local function update()
    vicious.force({config.widgets.volume.widget}) -- Update the volume widget
end

local function increase(device)
    vicious.contrib.pulse.add(5, device)
    update()
end

local function decrease(device)
    vicious.contrib.pulse.add(-5, device)
    update()
end

local function toggle(device)
    vicious.contrib.pulse.toggle(device)
    update()
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
