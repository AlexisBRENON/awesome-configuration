local log = require('utils/log')
local awful = require('awful')
local pulse = require("vicious/contrib/pulse")
local module = {}

local function escape(text)
    local special_chars = { ["."] = "%.", ["-"] = "%-" }
    return text:gsub("[%.%-]", special_chars)
end

local function get(device)
    local current_state = {
        volume = nil,
        muted = nil,
        output = nil
    }
    local f = io.popen("pacmd list-sinks")
    if f then
        for line in f:lines() do
            if line:match("name: <".. escape(device) ..">") then
                for line in f:lines() do
                    if line:match('^%s*volume:[^/]*/%s*(%d*)%%') then
                        current_state.volume = tonumber(line:match('^%s*volume:[^/]*/%s*(%d*)%%'))
                    elseif line:match('^%s*muted: (.*)') then
                        current_state.muted = (line:match('^%s*muted: (.*)') == "yes")
                    elseif line:match('^%s*active port: <.*(speaker).*>') or line:match('^%s*active port: <.*(headphone).*>') then
                        current_state.output = line:match('^%s*active port: <.*(speaker).*>') or line:match('^%s*active port: <.*(headphone).*>')
                    end
                end
            end
        end
        f:close()
    end
    return current_state
end

local function increase(percent, device)
    pulse.add(percent, device)
end

local function decrease(percent, device)
    pulse.add(-1 * percent, device)
end

local function mixer()
    awful.util.spawn("pavucontrol", false)
end

local function toggle(device)
    pulse.toggle(device)
end

local function is_supported(device)
    return (string.match(device, ".+%..+%-[0-9_a-b.]+%..+") ~= nil)
end

module = {
    name = "pulseaudio",
    has_vicious_support = true,
    vicious_widget = "vicious/contrib/pulse",
    is_supported = is_supported,
    get = get,
    increase = increase,
    decrease = decrease,
    toggle = toggle,
    mixer = mixer,
}

return module


