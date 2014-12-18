local awful        = require("awful")
local naughty      = require("naughty")
local vicious = require("vicious")
vicious.contrib = {
    pulse = require("vicious/contrib/pulse")
}

local volume = {}

local function update()
    vicious.force({config.widgets.volume.text}) -- Update the volume widget
end

local function increase()
    vicious.contrib.pulse.add(5, config.widgets.volume.device)
    update()
end

local function decrease()
    vicious.contrib.pulse.add(-5, config.widgets.volume.device)
    update()
end

local function toggle()
    vicious.contrib.pulse.toggle(config.widgets.volume.device)
    update()
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
