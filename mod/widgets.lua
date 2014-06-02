local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local awful = require("awful")
local naughty = require("naughty")

config.widget = {}


-- Separators
local sep_top_bottom    = wibox.widget.imagebox()
local sep_bottom_top    = wibox.widget.imagebox()
local sep_blank         = wibox.widget.textbox()
sep_top_bottom:set_image(beautiful.icons .. "/widgets/topBottom.png")
sep_bottom_top:set_image(beautiful.icons .. "/widgets/bottomTop.png")
sep_blank:set_text(" ")


-- Date
local datewidget = wibox.widget.textbox()
local dateformat = "%a %d/%m, %H:%M"
vicious.register(
    datewidget,
    vicious.widgets.date,
    dateformat,
    61
)
config.widget.date_widget = datewidget
-- Add an icon ??
-- Define funtions to display/hide calendar
local calendar = (
    function()
        local notification = nil
        local offset = 0

        local remove_calendar = function()
            if notification ~= nil then
                naughty.destroy(notification)
                notification = nil
                offset = 0
            end
        end

        local add_calendar = function(inc_offset)
            local new_offset = offset + inc_offset
            remove_calendar()
            offset = new_offset

            -- Get the right month to display
            local datespec = os.date("*t") -- Fetch the date of the day
            datespec = datespec.year * 12 + datespec.month - 1 + offset -- Compute date in months to add/remove offset
            datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12) -- Get back date+offset as 'month year'

            -- Get month calendar with week number and week starting on Monday
            local cal = awful.util.pread("ncal -w -M -m " .. datespec)
            
            -- Highlight the current day
            cal = cal:gsub(
                "_.([%d ])",
                string.format(
                    '<span bg_color="%s" color="%s">%%1</span>',
                    beautiful.bg_focus,
                    beautiful.fg_focus
                )
            )
            
            -- Display calendar with naughty
            notification = naughty.notify({
                text = cal,
                timeout = 0, -- No timeout
                screen = mouse.screen,
                font = beautiful.font_mono,
            })
        end
        return {
            display = add_calendar,
            hide = remove_calendar
        }
    end
)()

-- Display calendar when entering in date widget
datewidget:connect_signal("mouse::enter", function() calendar.display(0) end)
datewidget:connect_signal("mouse::leave", calendar.hide)
datewidget:buttons(
    awful.util.table.join(
        awful.button({ }, 3, function() calendar.display(-1) end),
        awful.button({ }, 1, function() calendar.display(1) end)
    )
)


-- Battery
-- TODO : Add a progress bar as battery charge
local batwidget = {}
batwidget.widget = wibox.widget.textbox()
vicious.register(
    batwidget.widget,
    vicious.widgets.bat,
    function (widget, args)
        local state = args[1]
        local current = args[2]

        -- Battery low and discharging
        if current < 10 and state == "-" then
            -- Maybe we want to display a small warning?
            if current ~= batwidget.lastwarn then
                batwidget.notification_id = naughty.notify({
                    title = "Batterie : niveau bas!",
                    preset = naughty.config.presets.critical,
                    timeout = 20,
                    text = args[3] .. " restante(s).",
                    icon = awful.util.geticonpath("battery-caution"),
                    replaces_id = batwidget.notification_id
                }).id
                batwidget.lastwarn = current
            end
        end
        -- TODO : hibernate computer if current is critical
        return args[1] .. current
    end,
    59,
    "BAT0"
)
config.widget.bat_widget = batwidget.widget


-- Volume level
local volwidget = wibox.widget.textbox()
vicious.register(
    volwidget,
    vicious.widgets.volume,
    function ( widget, args )
        local result = ""
        if args[2] == "♩" then
            result = "Mute"
        else
            result = args[1] .. "%"
        end
        return result
    end,
    17,
    "Master"
)
config.widget.vol_widget = volwidget
-- TODO : Add buttons


-- Systray (nothing fanzy)
local systray = wibox.widget.systray()


-- Per screen widgets
local promptbox = {}
local layoutbox = {}
local taglist   = {}
taglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle))

config.taglist = taglist
config.promptbox = promptbox

-- Wibox initialisation (one per screen)
local wibox_top = {}


-- Add widgets to wiboxes
for s = 1, screen.count() do
    promptbox[s] = awful.widget.prompt()
    layoutbox[s] = awful.widget.layoutbox(s)
    taglist[s] = awful.widget.taglist.new(
        s,
        awful.widget.taglist.filter.all,
        taglist.buttons
    )

    -- Create the wibox
    wibox_top[s] = awful.wibox({
        screen = s,
        position = "top",
        height = 16,
    })
    
    -- Add widgets to the wibox
    -- Widgets that are aligned to the left
    local left_group = wibox.layout.fixed.horizontal()
    left_group:add(layoutbox[s])
    left_group:add(taglist[s])
    left_group:add(sep_blank)
    left_group:add(promptbox[s])

    -- Widgets that are aligned to the right
    local right_group = wibox.layout.fixed.horizontal()
    right_group:add(sep_top_bottom)
    right_group:add(systray)
    right_group:add(sep_bottom_top)

    right_group:add(batwidget.widget)

    right_group:add(sep_top_bottom)
    right_group:add(volwidget)
    right_group:add(sep_bottom_top)

    right_group:add(datewidget)

    -- Now bring it all together
    local main_group = wibox.layout.align.horizontal()
    main_group:set_left(left_group)
    main_group:set_right(right_group)

    wibox_top[s]:set_widget(main_group)
end

-- Activate shifty now !
local shifty = require("shifty")
shifty.taglist = taglist
shifty.init()
