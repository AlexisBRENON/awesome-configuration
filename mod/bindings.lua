local brightness = require("brightness")
local volume = require("volume")

config.keys = {}
config.mouse = {}

local function screenshot(client)
    if client == "root" then
        client = "-window root"
    elseif client then
        client = "-window " .. client.window
    else
        client = ""
    end
    local path = "${HOME}/" ..
        "screenshot-" .. os.date("%Y-%m-%d--%H:%M:%S") .. ".jpg"
    awful.util.spawn("import -quality 95 " .. client .. " " .. path, false)
end


config.keys.global = awful.util.table.join(
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then
                client.focus:raise()
            end
        end,
        "Focus next window"),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end,
        "Focus previous window"),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        "Focus previously focused window"),
    awful.key({ modkey, "Control" }, "j",
        function ()
            screen_focus( 1)
        end,
        "Jump to next screen"),
    awful.key({ modkey, "Control" }, "k",
        function ()
            screen_focus(-1)
        end,
        "Jump to previous screen"),

    awful.key({ modkey,           }, "l",
        function ()
            awful.tag.incmwfact(0.05)
        end,
        "Increase master-width factor"),
    awful.key({ modkey,           }, "h",
        function ()
            awful.tag.incmwfact(-0.05)
        end,
        "Decrease master-width factor"),
    awful.key({ modkey,           }, "Up",
        function ()
            awful.layout.inc(config.layouts, 1)
        end,
        "Next layout"),
    awful.key({ modkey,          }, "Down",
        function ()
            awful.layout.inc(config.layouts, -1)
        end,
        "Previous layout"),
    
    awful.key({ modkey,           }, "Return",
        function ()
            awful.util.spawn(config.application.terminal.bin)
        end,
        "Spawn a terminal"),
    awful.key({ modkey,           }, "o",
        function ()
            awful.util.spawn(config.application.web_browser.bin)
        end,
        "Spawn a web browser"),
    awful.key({ modkey,           }, "space",
        function ()
            awful.util.spawn(config.application.file_browser.bin)
        end,
        "Spawn a file browser"),

    -- Screenshot
    awful.key({}, "Print",
        function()
            screenshot("root")
        end),
    awful.key({ "Shift" }, "Print",
        screenshot),

    -- Resart awesome
    awful.key({ modkey, "Control" }, "r", awful.util.restart),
    awful.key({ modkey, "Control" }, "q", awesome.quit),

    -- Multimedia keys
    awful.key({ }, "XF86MonBrightnessUp",   brightness.change), -- Changement is done by PC, we only report changement
    awful.key({ }, "XF86MonBrightnessDown", brightness.change),
    awful.key({ }, "XF86AudioRaiseVolume", volume.increase),
    awful.key({ }, "XF86AudioLowerVolume", volume.decrease),
    awful.key({ }, "XF86AudioMute",        volume.toggle)
)

config.keys.client = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
        end,
        "Fullscreen"),
    awful.key({ modkey,           }, "x",
        function (c)
            c:kill()
        end,
        "Close"),
    awful.key({ modkey, "Control" }, "Return",
        function (c)
            c:swap(awful.client.getmaster())
        end,
        "Switch with master window"),
    awful.key({ modkey,           }, "s",
        function (c)
            c.sticky = not c.sticky
        end,
        "Stick window"),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
            c:raise()
        end,
        "Maximize")
  )

config.mouse.client = awful.util.table.join(
    awful.button({ }, 1,
        function (c)
            client.focus = c
            c:raise()
        end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)
