local awful = require("awful")
local shifty = require("shifty")
local naughty = require("naughty")
local brightness = require("mod/brightness")
local volume = require("mod/volume")
local xrandr = require("mod/xrandr")
local keyboard = require("mod/keyboard")
local wlan = require("mod/wlan")
local screenshot = require("mod/screenshot")

config.keys = {}
config.mouse = {}

config.keys.global = awful.util.table.join(
  -- Disable/Enable WLAN networks
  awful.key({                   }, "XF86WLAN", wlan.toggle),
  -- Full screen shot
  awful.key({                   }, "Print", screenshot.full),
  -- Calculator prompt
  awful.key({ modkey            }, "F1",
    function()
      awful.prompt.run(
        { prompt = " = " },
        config.widgets.promptbox.widget[mouse.screen],
        function (expr)
          local result = awful.util.eval("return (" .. expr .. ")")
          naughty.notify({
            text = expr .. " = " .. result,
            timeout = 0
          })
        end
      )
    end),
  -- Default prompt
  awful.key({ modkey            }, "F2",
    function()
      awful.prompt.run(
        {prompt = "Run: "},
        config.widgets.promptbox.widget[mouse.screen],
        awful.util.spawn,
        awful.completion.shell,
        awful.util.getdir("cache") .. "/history"
      )
    end),
  -- Web search prompt
  awful.key({ modkey            }, "F12",
    function ()
      awful.prompt.run(
        {prompt = "Web search: "},
        config.widgets.promptbox.widget[mouse.screen],
        function (command)
          awful.util.spawn(
            config.application.web_browser.bin .. " 'http://yubnub.org/parser/parse?command=" .. command .. "'")
          -- Switch to the web tag (in my case it's tag 0)
          awful.tag.viewonly(shifty.getpos(0))
        end)
    end),
  -- Focus previously focused window
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end),
  -- Start the text editor
  awful.key({ modkey,           }, "e",
    function ()
      awful.util.spawn(config.application.text_editor.bin)
    end),
  -- Rename the current tag
  awful.key({ modkey            }, "r", shifty.rename),
  -- Create a new tag
  awful.key({ modkey            }, "t", shifty.add),
  -- Spawn a web browser
  awful.key({ modkey,           }, "o",
    function ()
      awful.util.spawn(config.application.web_browser.bin)
    end),
  -- Decrease master-width factor
  awful.key({ modkey,           }, "h",
    function ()
      awful.tag.incmwfact(-0.05)
    end),
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
  -- Increase master-width factor
  awful.key({ modkey,           }, "l",
    function ()
      awful.tag.incmwfact(0.05)
    end),
  -- Spawn a terminal
  awful.key({ modkey,           }, "Return",
    function ()
      awful.util.spawn(config.application.terminal.bin)
    end),
  -- Delete the current tag
  awful.key({ modkey            }, "w", shifty.del), -- delete a tag
  -- Next layout
  awful.key({ modkey,           }, "Up",
    function ()
      awful.layout.inc(awful.layout.layouts, 1, mouse.screen)
    end),
  -- Show previous tag
  awful.key({ modkey            }, "Left", awful.tag.viewprev),
  -- Previous layout
  awful.key({ modkey,           }, "Down",
    function ()
      awful.layout.inc(awful.layout.layouts, -1, mouse.screen)
    end),
  -- Show next tag
  awful.key({ modkey            }, "Right", awful.tag.viewnext),
  -- Restart awesome
  awful.key({ modkey, "Control" }, "r", awful.util.restart),
  -- Quit awesome
  awful.key({ modkey, "Control" }, "q", awesome.quit),
  -- Jump to next screen
  awful.key({ modkey, "Control" }, "j",
    function ()
      awful.screen.focus_relative(1)
    end),
  -- Jump to previous screen
  awful.key({ modkey, "Control" }, "k",
    function ()
      awful.screen.focus_relative(-1)
    end),
  -- Activate screensaver
  awful.key({ modkey, "Control" }, "space",
    function ()
      awful.util.spawn("xscreensaver-command -activate")
    end),
  -- Toggle volume
  awful.key({ modkey, "Shift"   }, "F1", function () volume.toggle(config.widgets.volume.device) end),
  -- Decrease volume
  awful.key({ modkey, "Shift"   }, "F2", function () volume.decrease(config.widgets.volume.device) end),
  -- Increase volume
  awful.key({ modkey, "Shift"   }, "F3", function () volume.increase(config.widgets.volume.device) end),
  -- Switch between screens configurations
  awful.key({ modkey, "Shift"   }, "F7", xrandr.change_screen),
  -- Increase screen backlight
  awful.key({ modkey, "Shift"   }, "F12", brightness.increase),
  -- Decrease screen backlight
  awful.key({ modkey, "Shift"   }, "F11", brightness.decrease),
  -- Change keyboard layout
  awful.key({ modkey, "Shift"   }, "space", keyboard.change_layout),
  -- -- Send client to prev tag
  awful.key({ modkey, "Shift"   }, "Left", shifty.send_prev),
  -- Send client to next tag
  awful.key({ modkey, "Shift"   }, "Right", shifty.send_next),
  -- Selection screenshot
  awful.key({         "Shift"   }, "Print", screenshot.selection)
)

-- Numbers row a top of keyboard has keycode from 10 to ...
-- Use keycode instead of keysym to make it work on any keyboard/layout, etc.
for i = 1, 10 do
    config.keys.global = awful.util.table.join(
    config.keys.global,
    awful.key({ modkey,          }, "#" .. 9 + i,
    function()
      awful.tag.viewonly(shifty.getpos(i))
    end)
    )
end

config.keys.client = awful.util.table.join(
  -- Stick window
  awful.key({ modkey,           }, "s",
    function (c)
      c.sticky = not c.sticky
    end),
  -- Fullscreen
  awful.key({ modkey,           }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
    end),
  -- Maximize
  awful.key({ modkey,           }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
      c:raise()
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
  -- Move client to previous screen
  awful.key({ modkey, "Shift", "Control"}, "Left",
    function(c)
      awful.client.movetoscreen(c, awful.util.cycle(screen.count(), c.screen-1))
    end),
  -- Move client to next screen
  awful.key({ modkey, "Shift", "Control"}, "Right",
    function(c)
      awful.client.movetoscreen(c, awful.util.cycle(screen.count(), c.screen+1))
    end),
  -- Window
  awful.key({ "Control" }, "Print", screenshot.window)
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
