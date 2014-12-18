local naughty = require("naughty")
local beautiful = require("beautiful")

local screenshot = {}
local notification_id = nil

local function take_screenshot(client)
    local image_name = "screenshot-" .. os.date("%m-%d_%H-%M-%S") .. ".jpg"
    local path = os.getenv("HOME") .. "/" .. image_name
    os.execute("import -quality 95 " .. client .. " " .. path)
    notification_id = naughty.notify({
        text = image_name .. " enregistrée.",
        icon = beautiful.icons .. "/screenshot/notify.png",
        icon_size = config.widgets.wiboxes.top.size,
        replaces_id = notification_id,
    }).id
end

local function full_screenshot()
    take_screenshot("-window root")
end

local function window_screenshot(client)
    take_screenshot("-window " .. client.window)
end

local function selection_screenshot()
    take_screenshot("")
end

screenshot.full = full_screenshot
screenshot.window = window_screenshot
screenshot.selection = selection_screenshot

return screenshot
