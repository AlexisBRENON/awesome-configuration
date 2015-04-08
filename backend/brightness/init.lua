-- Handle brightness
local naughty = require("naughty")
local beautiful = require("beautiful")
local log = require("utils/log")
local submodule = require("utils/submodule")

local brightness = {}

local import_name = ...
local notification_id = nil
local _increase = nil
local _decrease = nil

local function notify()
    local backlight_percent = _get()
    notification_id = naughty.notify({
        text = backlight_percent .. "%",
        icon = beautiful.icons .. "/brightness/" .. backlight_percent .. ".png",
        icon_size = 22,
        replaces_id = notification_id
    }).id
end

local function init()
    -- Search for a supported backend
    for _, backend_import_name in ipairs(submodule.fetch_submodules(import_name)) do
        local backend = require(backend_import_name)
        if backend.is_supported() then
            log.info('backlight support : ON (' .. backend.name ..')')
            _increase = backend.increase
            _decrease = backend.decrease
            _get = backend.get
            _set = backend.set
        end
    end
    -- If not found assign a warning function
    if _get == nil then
        log.info('backlight support : OFF')
        local function fallback ()
            log.warning('backlight not supported...')
        end
        _increase = fallback
        _decrease = fallback
        _get = fallback
        _set = fallback
    end
end

function brightness.increase()
    _increase()
    notify()
end

function brightness.decrease()
    _decrease()
    notify()
end

init()
return brightness
