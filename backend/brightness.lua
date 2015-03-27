-- Handle brightness (with xbacklight)
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local log = require("utils/log")

local brightness = {}

local current_backlight = 0
local notification_id = nil
local last_call = os.time()
local initialized = false
local _increase = nil
local _decrease = nil

local function has_xbacklight_support()
    local f = io.popen("xbacklight -get")
    local result = (type(tonumber(f:read("*all"))) == 'number')
    f:close()
    return result
end

local function update_current_xbacklight()
    local f = io.popen("xbacklight -get")
    current_backlight = math.floor(tonumber(f:read("*all"))/10)
    f:close()
end

local function notify()
    update_current_xbacklight()
    notification_id = naughty.notify({
        text = current_backlight .. "0%",
        icon = beautiful.icons .. "/brightness/" .. current_backlight .. ".png",
        icon_size = 22,
        replaces_id = notification_id
    }).id
end

local function xbacklight_increase()
    os.execute('xbacklight -set ' .. current_backlight+1 .. "1")
    notify()
end

local function xbacklight_decrease()
    if (current_backlight == 0 and os.time() > last_call) then
        -- Let a delay before turning off the screen
        os.execute("sleep 1 ; xset dpms force off")
    else
        os.execute('xbacklight -set ' .. current_backlight-1 .. "1")
        notify()
    end
    last_call = os.time()
end

local function init()
    if has_xbacklight_support() then
        log.debug('backlight support : ON (xbacklight)')
        _increase = xbacklight_increase
        _decrease = xbacklight_decrease
        update_current_xbacklight()
    else
        log.info('backlight support : OFF')
        local function fallback ()
            log.warning('backlight not supported...')
        end
        _increase = fallback
        _decrease = fallback
    end
    initialized = true
end

function brightness.increase()
    if not initialized then
        init()
    end
    _increase()
end

function brightness.decrease()
    if not initialized then
        init()
    end
    _decrease()
end

return brightness
