-- Handle volume
local naughty = require("naughty")
local vicious = require("vicious")
local beautiful = require("beautiful")
local log = require("utils/log")
local submodule = require("utils/submodule")

local volume = {}

local import_name = ...
local models = {}

local function get_icon(status)
    local icon_path = "widgets/volume/"
    if status.muted then
        icon_path = icon_path .. "mute.png"
    else
        if status.output == "speaker" then
            icon_path = icon_path .. math.floor(status.volume/10) .. ".png"
        elseif status.output == "headphone" then
            icon_path = icon_path .. "headset.png"
        end
    end
    return (beautiful.icons .. icon_path)
end

local function notify(model)
    local status = model.backend.get(model.device)
    model.notification_id = naughty.notify({
        text = status.volume .. "%",
        icon = get_icon(status),
        icon_size = beautiful.naughty_icon_size,
        replaces_id = model.notification_id
    }).id
end

local function update_views(model, send_notification)
    for _, widget in ipairs(model.views) do
        vicious.force({widget}) -- Update the volume widget
    end
    if send_notification then
        notify(model)
    end
end

function volume.add_widget(model, widget)
    table.insert(model.views, widget)
end

local function increase(model)
    return function()
        model.backend.increase(5, model.device)
        update_views(model, true)
    end
end

local function decrease(model)
    return function()
        model.backend.decrease(5, model.device)
        update_views(model, true)
    end
end

local function toggle(model)
    return function()
        model.backend.toggle(model.device)
        update_views(model, true)
    end
end


function volume.vicious_format(widget, args)
    local model = widget.model
    local status = model.backend.get(model.device)
    local text = ""

    if status.muted then
        text = "Muted"
    else
        text = status.volume .. "%"
    end
    widget.text:set_text(text)
    widget.icon:set_image(get_icon(status))
    
    -- Take that vicious
    -- I already updated the text and icon
    return widget.text
end

function volume.init(_device_name)
    if models[_device_name] == nil then
        volume_model = {
            views = {}
        }
        -- Search for a supported backend
        for _, backend_import_name in ipairs(submodule.fetch_submodules(import_name)) do
            local tested_backend = require(backend_import_name)
            if tested_backend.is_supported(_device_name) then
                log.info('volume support : ON (' .. tested_backend.name ..')')
                volume_model.backend = tested_backend
                volume_model.device = _device_name
                -- Define the right functions for the facade depending on backend
                -- (Thanks functional programming ;-) )
                volume_model.increase = increase(volume_model)
                volume_model.decrease = decrease(volume_model)
                volume_model.toggle = toggle(volume_model)
                models[_device_name] = volume_model
            end
        end
        -- If not found assign a warning function
        if not models[_device_name] then
            log.info('volume support : OFF')
        end
    end
    return models[_device_name]
end

return volume
