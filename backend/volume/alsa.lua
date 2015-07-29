local terminal = require('config/applications').terminal
local awful_wrapper = require('backend/awesome_wrapper/awful')
local module = {}

local function get(device)
    local current_state = {
        volume = nil,
        muted = nil,
        output = nil
    }
    local f = io.popen("amixer -M get " .. device)
    local mixer = f:read("*all")
    f:close()

    -- Capture mixer control state:          [5%] ... ... [on]
    local volu, mute = string.match(mixer, "([%d]+)%%.*%[([%l]*)")
    current_state.volume = tonumber(volu)
    current_state.muted = (mute == "off")
    current_state.output = "speaker"
    return current_state
end

local function change(device, how)
    os.execute("amixer -q sset " .. device .. " " .. how)
end

local function increase(percent, device)
    change(device, percent .. "%+")
end

local function decrease(percent, device)
    change(device, percent .. "%-")
end

local function mixer()
    awful_wrapper.spawn(terminal .. " --exec=alsamixer") 
end

local function toggle(device)
    change(device, "toggle")
end

local function is_supported(device)
    return (os.execute("amixer -M get " .. device) == true)
end

module = {
    name = "alsa",
    has_vicious_support = true,
    vicious_widget = "vicious/widgets/volume",
    is_supported = is_supported,
    get = get,
    increase = increase,
    decrease = decrease,
    toggle = toggle,
    mixer = mixer,
}

return module


