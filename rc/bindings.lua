config.keys = {}
config.mouse = {}
local volume = loadrc("volume", "vbe/volume")
local brightness = loadrc("brightness", "vbe/brightness")
local keydoc = loadrc("keydoc", "vbe/keydoc")

local function screenshot(client)
  if client == "root" then
    client = "-window root"
  elseif client then
    client = "-window " .. client.window
  else
    client = ""
  end
  local path = awful.util.getdir("config") .. "/screenshots/" ..
  "screenshot-" .. os.date("%Y-%m-%d--%H:%M:%S") .. ".jpg"
  awful.util.spawn("import -quality 95 " .. client .. " " .. path, false)
end


-- Function to toggle a given window to the currently selected and
-- focused tag. We need a filter. This function can be used to focus a
-- particular window. When the filter is unable to select something,
-- we undo previous actions (hence "toggle"). This function returns a
-- function that will effectively toggle things.
local function toggle_window(filter)
  local undo = {} -- undo stack
  client.add_signal('unmanage',
    function(c)
      -- If the client is in the undo stack, remove it
      while true do
        idx = awful.util.table.hasitem(undo, c)
        if not idx then break end
        table.remove(undo, idx)
      end
    end
    )
  local toggle =
  function()
    -- "Current" screen
    local s = client.focus and client.focus.screen or mouse.screen
    local cl = filter()	-- Client to toggle
    if cl and client.focus ~= cl then
      -- So, we have a client.
      if not cl:isvisible() then
        -- But it is not visible. So we will add it to the current
        -- tag of the screen where it currently is
        local t = assert(awful.tag.selected(cl.screen))
        -- Add our tag to the client
        undo[#undo + 1] = { cl, t }
        awful.client.toggletag(t, cl)
      end

      -- Focus and raise the client
      if s ~= cl.screen then
        mouse.screen = cl.screen
      end
      client.focus = cl
      cl:raise()
    else
      -- OK, we need to restore the previously pushed window to its
      -- original state.
      local i = #undo
      while i > 0 do
      local cl, t = unpack(undo[i])
      -- We only handle visible clients that are attached to the
      -- appropriate tag. Otherwise, we try the next one.
      if cl and cl:isvisible() and t.selected and
        awful.util.table.hasitem(cl:tags(), t) then
        awful.client.toggletag(t, cl)
        table.remove(undo, i)
        return
      end
      i = i - 1
    end
    
    -- Clean up...
    while #undo > 10 do
      table.remove(undo, 1)
    end
  end
end
return toggle
end

-- Toggle urgent window
local toggle_urgent = toggle_window(awful.client.urgent.get)

-- Focus a relative screen (similar to `awful.screen.focus_relative`)
local function screen_focus(i)
  local s = awful.util.cycle(screen.count(), mouse.screen + i)
  local c = awful.client.focus.history.get(s, 0)
  mouse.screen = s
  if c then client.focus = c end
end

local music = loadrc("spotify", "vbe/spotify")

local display_nmaster_ncol = (
  function()
    local nid = nil
    return (
      function()
        local nmaster = awful.tag.getnmaster()
        local ncol = awful.tag.getncol()
        nid = naughty.notify(
        {
          title = "Tag configuration",
          timeout = 5,
          text = "Number of masters: " .. nmaster ..
          "\nNumber of columns: " .. ncol,
          replaces_id = nid
        }
        ).id
      end
      )
  end
  )()

config.keys.global = awful.util.table.join(
  keydoc.group("Focus"),
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

  keydoc.group("Layout manipulation"),
  awful.key({ modkey,           }, "l",
    function ()
      awful.tag.incmwfact( 0.05)
    end,
    "Increase master-width factor"),
  awful.key({ modkey,           }, "h",
    function ()
      awful.tag.incmwfact(-0.05)
    end,
    "Decrease master-width factor"),
  awful.key({ modkey, "Shift"   }, "l",
    function ()
      awful.tag.incnmaster(1)
      display_nmaster_ncol()
    end,
    "Increase number of masters"),
  awful.key({ modkey, "Shift"   }, "h",
    function ()
      awful.tag.incnmaster(-1)
      display_nmaster_ncol()
    end,
    "Decrease number of masters"),
  awful.key({ modkey, "Control" }, "l",
    function ()
      awful.tag.incncol(1)
      display_nmaster_ncol()
    end,
    "Increase number of columns"),
  awful.key({ modkey, "Control" }, "h",
    function ()
      awful.tag.incncol(-1)
      display_nmaster_ncol()
    end,
    "Decrease number of columns"),
  awful.key({ modkey,           }, "Up",
    function ()
      awful.layout.inc(config.layouts,  1)
    end,
    "Next layout"),
  awful.key({ modkey,          }, "Down",
    function ()
      awful.layout.inc(config.layouts, -1)
    end,
    "Previous layout"),
  awful.key({ modkey, "Shift"   }, "j",
    function ()
      awful.client.swap.byidx(  1)
    end,
    "Swap with next window"),
  awful.key({ modkey, "Shift"   }, "k",
    function ()
      awful.client.swap.byidx( -1)
    end,
    "Swap with previous window"),

  keydoc.group("Misc"),
  awful.key({ modkey,           }, "Return",
    function ()
      awful.util.spawn(config.terminal)
    end,
    "Spawn a terminal"),
  awful.key({ modkey,           }, "o",
    function ()
      awful.util.spawn(config.browser)
    end,
    "Spawn a web browser"),
  awful.key({ modkey,           }, "space",
    function ()
      awful.util.spawn(config.filebrowser)
    end,
    "Spawn a filebrowser"),

  -- Screenshot
  awful.key({}, "Print",
    function()
      screenshot("root")
    end),
  awful.key({ "Shift" }, "Print",
    screenshot),

  -- Restart awesome
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Control" }, "q", awesome.quit),

  -- Multimedia keys
  awful.key({ }, "XF86MonBrightnessUp",   brightness.increase),
  awful.key({ }, "XF86MonBrightnessDown", brightness.decrease),
  awful.key({ }, "XF86AudioRaiseVolume", volume.increase),
  awful.key({ }, "XF86AudioLowerVolume", volume.decrease),
  awful.key({ }, "XF86AudioMute",        volume.toggle),

  -- Help
  awful.key({ modkey, }, "F1", keydoc.display)
)

config.keys.client = awful.util.table.join(
  keydoc.group("Window-specific bindings"),
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
  awful.key({ modkey,           }, "o",
    function (c)
      if screen.count() == 1 then return nil end
      local s = awful.util.cycle(screen.count(), c.screen + 1)
      if awful.tag.selected(s) then
        c.screen = s
        client.focus = c
        c:raise()
      end
    end,
    "Move to the other screen"),
  awful.key({ modkey, "Control" }, "space",
    awful.client.floating.toggle,
    "Toggle floating"),
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
  awful.key({ modkey,           }, "i",
    dbg,
    "Get client-related information"),
  awful.key({ modkey,           }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
      c:raise()
    end,
    "Maximize")
  )

keydoc.group("Misc")

config.mouse.client = awful.util.table.join(
  awful.button({ }, 1,
    function (c)
      client.focus = c
      c:raise()
    end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
  )
