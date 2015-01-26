local beautiful = require('beautiful')
local module = {}

function module.init(widget)
    module.tooltip = widget.tooltip or nil
    module.text = widget.text or nil
    module.icon = widget.icon or nil
    return module
end

local function set_icon(state, current)
    -- Choose the icon to display
    local icon_dir = "widgets/battery/"
    if state == "−" then
        -- battery discharging
        icon_dir = icon_dir .. "discharging/"
    elseif state == "+" or state == "↯" then
        -- Battery charging or full
        icon_dir = icon_dir .. "charging/"
    elseif state == "⌁" then
        -- Battery state unknown
        icon_dir = icon_dir .. "unknown/"
    end
    -- Set the right icon
    local icon_level = math.floor(tonumber(current)/10)
    module.icon:set_image(beautiful.icons .. icon_dir .. icon_level .. ".png")
end

local function notify(state, current, time)
    -- Notify user if battery low
    if current < 10 and state == "−" then
        -- Display a new notification only when percentage decreases
        if current < module.lastwarn then
            config.widgets.battery.notification_id = naughty.notify({
                title = "Batterie : niveau bas!",
                preset = naughty.config.presets.critical,
                timeout = 20,
                text = time .. " restante(s)",
                icon = beautiful.icons .. icon_dir .. icon_level .. ".png",
                replaces_id = config.widgets.battery.notification_id,
            }).id
            config.widgets.battery.lastwarn = current
        end
    end
    -- TODO : hibernate computer if current is critical
end

function module.update_icon_percent (widget, args)
    local state = args[1]
    local current = args[2]
    local time = args[3]
    local result = current .. "%"

    module.tooltip:set_text("Temps restant : " .. time)
    set_icon(state, current)
    notify(state, current, time)

    return result
end

return module

