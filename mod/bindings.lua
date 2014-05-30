local awful = require("awful")
local brightness = require("mod/brightness")
local volume = require("mod/volume")
local shifty = require("shifty")

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
    -- Focus next window
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then
                client.focus:raise()
            end
        end),
    -- Focus previous window
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end),
    -- Focus previously focused window
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    -- Jump to next screen
    awful.key({ modkey, "Control" }, "j",
        function ()
            screen_focus( 1)
        end),
    -- Jump to previous screen
    awful.key({ modkey, "Control" }, "k",
        function ()
            screen_focus(-1)
        end),

    -- Increase master-width factor
    awful.key({ modkey,           }, "l",
        function ()
            awful.tag.incmwfact(0.05)
        end),
    -- Decrease master-width factor
    awful.key({ modkey,           }, "h",
        function ()
            awful.tag.incmwfact(-0.05)
        end),
    -- Next layout
    awful.key({ modkey,           }, "Up",
        function ()
            awful.layout.inc(awful.layout.layouts, 1)
        end),
    -- Previous layout
    awful.key({ modkey,          }, "Down",
        function ()
            awful.layout.inc(awful.layout.layouts, -1)
        end),
    
    -- Spawn a terminal
    awful.key({ modkey,           }, "Return",
        function ()
            awful.util.spawn(config.application.terminal.bin)
        end),
    -- Spawn a web browser
    awful.key({ modkey,           }, "o",
        function ()
            awful.util.spawn(config.application.web_browser.bin)
        end),
    -- Spawn a file browser
    awful.key({ modkey,           }, "space",
        function ()
            awful.util.spawn(config.application.file_browser.bin)
        end),

    -- Tag manipulation
    awful.key({modkey}, "Left", awful.tag.viewprev),
    awful.key({modkey}, "Right", awful.tag.viewnext),
    awful.key({modkey}, "w", shifty.del), -- delete a tag
    awful.key({modkey, "Shift"}, "Left", shifty.send_prev), -- client to prev tag
    awful.key({modkey, "Shift"}, "Right", shifty.send_next), -- client to next tag
    awful.key({modkey}, "t", shifty.add), -- creat a new tag
    awful.key({modkey}, "r", shifty.rename), -- rename a tag

    -- Display prompt box
    awful.key({modkey}, "F2",
        function()
            awful.prompt.run(
                {prompt = "Run: "},
                config.promptbox[mouse.screen].widget,
                awful.util.spawn, awful.completion.shell,
                awful.util.getdir("cache") .. "/history"
            )
        end),
    
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

for i = 0, 9 do
    config.keys.global = awful.util.table.join(
        config.keys.global,
        -- View tag only.
        awful.key({ modkey }, "KP_" .. i,
            function ()
                awful.tag.viewonly(shifty.getpos(i+1))
            end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "KP_" .. i,
            function ()
                local t = shifty.getpos(i+1)
                t.selected = not t.selected    
            end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "KP_" .. i,
            function ()
                if client.focus then
                    -- remember the focused client because getpos() switch
                    -- to new tag (if it doesn't exist) and the client lost focus
                    local c = client.focus
                    t = shifty.getpos(i+1)
                    awful.client.movetotag(t, c)
                    awful.tag.viewonly(t)
                end
            end)
    )
end


config.keys.client = awful.util.table.join(
    -- Fullscreen
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
        end),
    -- Close
    awful.key({ modkey,           }, "x",
        function (c)
            c:kill()
        end),
    -- Switch with master window
    awful.key({ modkey, "Control" }, "Return",
        function (c)
            c:swap(awful.client.getmaster())
        end),
    -- Stick window
    awful.key({ modkey,           }, "s",
        function (c)
            c.sticky = not c.sticky
        end),
    -- Maximize
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
            c:raise()
        end)
)

config.mouse.global = {}

config.mouse.client = awful.util.table.join(
    awful.button({ }, 1,
        function (c)
            client.focus = c
            c:raise()
        end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Actually apply bindings
root.keys(config.keys.global)
shifty.config.clientkeys = config.keys.client
shifty.config.modkey = modkey

root.buttons(config.mouse.global)
-- The clients buttons will be added in rules