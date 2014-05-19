-- Widgets

vicious = require("vicious")
wibox = require("wibox")
local icons = loadrc("icons", "vbe/icons")

-- Separators
local sepopen = wibox.widget.textbox()
sepopen:set_text("[ ")
local sepclose = wibox.widget.textbox()
sepclose:set_text(" ]")
local spacer = wibox.widget.textbox()
spacer:set_text(" ][ ")
local sepblank = wibox.widget.textbox()
sepblank:set_text(" ")

-- Date
local datewidget = wibox.widget.textbox()
local dateformat = "%H:%M"
if screen.count() > 1 then dateformat = "%a %d/%m, " .. dateformat end
vicious.register(
  datewidget,
  vicious.widgets.date,
  '<span color="' .. beautiful.fg_widget_clock .. '">' ..
  dateformat .. '</span>',
  61
)
local dateicon = wibox.widget.imagebox()
dateicon:set_image(beautiful.icons .. "/widgets/clock.png")
local cal = (
  function()
    local calendar = nil
    local offset = 0

    local remove_calendar = function()
      if calendar ~= nil then
        naughty.destroy(calendar)
        calendar = nil
        offset = 0
      end
    end

    local add_calendar = function(inc_offset)
      local save_offset = offset
      remove_calendar()
      offset = save_offset + inc_offset
      local datespec = os.date("*t")
      datespec = datespec.year * 12 + datespec.month - 1 + offset
      datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
      local cal = awful.util.pread("ncal -w -m " .. datespec)
      -- Highlight the current date and month
      cal = cal:gsub(
        "_.([%d ])",
        string.format(
          '<span color="%s">%%1</span>',
          beautiful.fg_widget_clock
        )
      )
      cal = cal:gsub(
        "^( +[^ ]+ [0-9]+) *",
        string.format(
          '<span color="%s">%%1</span>',
          beautiful.fg_widget_clock
        )
      )
      -- Turn anything other than days in labels
      cal = cal:gsub(
        "(\n[^%d ]+)",
        string.format(
          '<span color="%s">%%1</span>',
          beautiful.fg_widget_label
        )
      )
      cal = cal:gsub(
        "([%d ]+)\n?$",
        string.format(
          '<span color="%s">%%1</span>',
          beautiful.fg_widget_label
        )
      )
      calendar = naughty.notify(
        {
          text = string.format(
            '<span font="%s">%s</span>',
            "DejaVu Sans Mono 8",
            cal:gsub(" +\n","\n")
          ),
          timeout = 0,
          hover_timeout = 0.5,
          width = 160,
          screen = mouse.screen,
        }
      )
    end

    return {
      add = add_calendar,
      rem = remove_calendar
    }
  end
)()

datewidget:connect_signal("mouse::enter", function() cal.add(0) end)
datewidget:connect_signal("mouse::leave", cal.rem)
datewidget:buttons(
  awful.util.table.join(
    awful.button({ }, 3, function() cal.add(-1) end),
    awful.button({ }, 1, function() cal.add(1) end)
  )
)

-- CPU usage
local cpuwidget = wibox.widget.textbox()
vicious.register(
  cpuwidget,
  vicious.widgets.cpu,
  function (widget, args)
    return string.format(
      '<span color="' .. beautiful.fg_widget_value .. '">%2d%%</span>',
      args[1]
    )
  end,
  7
)
local cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.icons .. "/widgets/cpu.png")

-- Battery
local batwidget = { widget = "" }
batwidget.widget = wibox.widget.textbox()
vicious.register(
  batwidget.widget,
  vicious.widgets.bat,
  function (widget, args)
    local color = beautiful.fg_widget_value
    local current = args[2]
    if current < 10 and args[1] == "-" then
      color = beautiful.fg_widget_value_important
      -- Maybe we want to display a small warning?
      if current ~= batwidget.lastwarn then
        batwidget.lastid = naughty.notify(
          {
            title = "Battery low!",
            preset = naughty.config.presets.critical,
            timeout = 20,
            text = "Battery level is currently " ..
              current .. "%.\n" .. args[3] ..
              " left before running out of power.",
            icon = icons.lookup(
              {
                name = "battery-caution",
                type = "status"
              }
            ),
            replaces_id = batwidget.lastid
          }
        ).id
        batwidget.lastwarn = current
      end
    end
    return string.format(
      '<span color="' .. color ..
        '">%s%d%%</span>', args[1], current)
  end,
  59,
  "BAT0"
)
local baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.icons .. "/widgets/bat.png")

-- Network
local netup   = wibox.widget.textbox()
local netdown = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox()
netupicon:set_image(beautiful.icons .. "/widgets/up.png")
local netdownicon = wibox.widget.imagebox()
netdownicon:set_image(beautiful.icons .. "/widgets/down.png")

local netgraph = awful.widget.graph()
netgraph:set_width(80):set_height(16)
netgraph:set_stack(true):set_scale(true)
netgraph:set_border_color(beautiful.fg_widget_border)
netgraph:set_stack_colors({ "#EF8171", "#cfefb3" })
netgraph:set_background_color("#00000033")
vicious.register(
  netup,
  vicious.widgets.net,
  function (widget, args)
    -- We sum up/down value for all interfaces
    local up = 0
    local down = 0
    local iface
    for name, value in pairs(args) do
      iface = name:match("^{(%S+) down_b}$")
      if iface and iface ~= "lo" then down = down + value end
      iface = name:match("^{(%S+) up_b}$")
      if iface and iface ~= "lo" then up = up + value end
    end
    -- Update the graph
    netgraph:add_value(up, 1)
    netgraph:add_value(down, 2)
    -- Format the string representation
    local format = function(val)
      if val > 500000 then
        return string.format("%.1f MB", val/1000000.)
      elseif val > 500 then
        return string.format("%.1f KB", val/1000.)
      end
      return string.format("%d B", val)
    end
    -- Down
    netdown.text = string.format(
      '<span color="' .. beautiful.fg_widget_value ..
        '">%08s</span>',
      format(down)
    )
    -- Up
    return string.format(
      '<span color="' .. beautiful.fg_widget_value ..
      '">%08s</span>', format(up)
    )
  end,
  3
)

-- Memory usage
local memwidget = wibox.widget.textbox()
vicious.register(
  memwidget,
  vicious.widgets.mem,
  '<span color="' .. beautiful.fg_widget_value .. '">$1%</span>',
  19
)
local memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.icons .. "/widgets/mem.png")

-- Volume level
local volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.icons .. "/widgets/vol.png")
local volwidget = wibox.widget.textbox()
vicious.register(
  volwidget,
  vicious.widgets.volume,
  '<span color="' .. beautiful.fg_widget_value .. '">$2 $1%</span>',
  17,
  "Master"
)
volume = loadrc("volume", "vbe/volume")
volwidget:buttons(
  awful.util.table.join(
    awful.button({ }, 1, volume.mixer),
    awful.button({ }, 3, volume.toggle),
    awful.button({ }, 4, volume.increase),
    awful.button({ }, 5, volume.decrease)
  )
)

-- File systems
local fs = {
  "/",
  "/home",
  "/var",
  "/usr",
  "/tmp",
  "/var/cache/build",
  "/var/lib/mongodb",
  "/var/lib/systems"
}
local fsicon = wibox.widget.imagebox()
fsicon:set_image(beautiful.icons .. "/widgets/disk.png")
local fswidget = wibox.widget.textbox()
vicious.register(
  fswidget,
  vicious.widgets.fs,
  function (widget, args)
    local result = ""
    for _, path in pairs(fs) do
      local used = args["{" .. path .. " used_p}"]
      local color = beautiful.fg_widget_value
      if used then
        if used > 90 then
          color = beautiful.fg_widget_value_important
        end
        local name = string.gsub(path, "[%w/]*/(%w+)", "%1")
        if name == "/" then name = "root" end
        result = string.format(
          '%s%s<span color="' .. beautiful.fg_widget_label .. '">%s: </span>' ..
          '<span color="' .. color .. '">%2d%%</span>',
          result, #result > 0 and " " or "", name, used)
      end
    end
    return result
  end,
  53,
  "-lx fuse -x aufs"
)

local systray = wibox.widget.systray()

-- Wibox initialisation
local wiboxbar  = {}
local promptbox = {}
local layoutbox = {}
local taglist = {}

for s = 1, screen.count() do
  promptbox[s] = awful.widget.prompt()
  layoutbox[s] = awful.widget.layoutbox(s)
  
  -- Create the taglist
  taglist[s] = awful.widget.taglist.new(s,
    awful.widget.taglist.filter.all)
  -- Create the wibox
  wiboxbar[s] = awful.wibox({ screen = s,
    fg = beautiful.fg_normal,
    bg = beautiful.bg_widget,
    position = "top",
    height = 16,
    })
  -- Add widgets to the wibox
  local on = function(n, what, layout)
    if s == n or n > screen.count() then
      layout:add(what)
    end
  end

  -- Widgets that are aligned to the left
  local left_layout = wibox.layout.fixed.horizontal()
  left_layout:add(layoutbox[s])
  left_layout:add(taglist[s])
  left_layout:add(promptbox[s])

  -- Widgets that are aligned to the right
  local right_layout = wibox.layout.fixed.horizontal()
  right_layout:add(systray)
  
  right_layout:add(sepopen)
  
  right_layout:add(datewidget)
  right_layout:add(dateicon)
  
  right_layout:add(spacer)
  
  right_layout:add(volwidget)

  right_layout:add(spacer)

  right_layout:add(batwidget.widget)
  right_layout:add(baticon)

  right_layout:add(sepclose)
  
  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_right(right_layout)

  wiboxbar[s]:set_widget(layout)
end

config.keys.global = awful.util.table.join(
  config.keys.global,
  awful.key({ modkey }, "r", function () promptbox[mouse.screen]:run() end,
    "Prompt for a command"
  )
)

config.taglist = taglist
