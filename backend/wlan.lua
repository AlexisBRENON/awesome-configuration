local naughty = require("naughty")
local beautiful = require("beautiful")

wlan = {}

local soft_blocked = false
local hard_blocked = false
local notification_id = nil

local function init()
    local rfkill = io.popen("rfkill list wifi")
    if rfkill then
        for line in rfkill:lines() do
            s_blocked = line:match("^%s*Soft blocked: (yes|no)%s*$")
            if s_blocked and s_blocked == "yes" then
                soft_blocked = true
            end
            h_blocked = line:match("^%s*Hard blocked: (yes|no)%s*$")
            if h_blocked and h_blocked == "yes" then
                hard_blocked = true
            end
        end
        rfkill:close()
    end
    if soft_blocked then
        os.execute("rfkill block all") -- Make sure that ALL devices are blocked
    end
end

local function notify()
    title = nil
    text = nil
    icon = nil
    if hard_blocked then
        title = "Attention : périphériques matériellement indisponibles"
    end
    if soft_blocked then
        text = "WLAN désactivé"
        icon = "off.png"
    else
        text = "WLAN activé"
        icon = "on.png"
    end
    notification_id = naughty.notify({
        title = title,
        text = text,
        icon = beautiful.icons .. "/wlan/" .. icon,
        icon_size = config.widgets.wiboxes.top.size,
        replaces_id = notification_id,
    }).id
end

local function toggle()
    local command = ""
    if soft_blocked then
        command = "unblock"
    else
        command = "block"
    end
    os.execute("rfkill " .. command .. " all")
    soft_blocked = not soft_blocked
    notify()
end

wlan.toggle = toggle

init()
return wlan
