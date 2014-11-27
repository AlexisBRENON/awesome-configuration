local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
vicious.contrib = {
    pulse = require("vicious/contrib/pulse")
}
local awful = require("awful")
local naughty = require("naughty")
local volume = require("mod/volume")
local gears = require("gears")

config.widgets = {
    wiboxes = {
        top = {
            widget = {}, -- One widget per screen
            size = 22,
            bg = gears.color.create_pattern({
                type="linear",
                from={0,0},
                to={0,22},
                stops={
                    {1, beautiful.bg_normal .. "00"},
                    {0, beautiful.bg_normal .. "99"},
                }
            }),
        }
    },
    date_time = {
        widget = nil,
        update_time = 61,
        format = "%a %d/%m, %H:%M",
    },
    battery = {
        widget = nil,
        text = {
            widget = nil,
        },
        icon = {
            widget = nil,
        },
        tooltip = nil,
        time = "0",
        update_time = 59,
        device = "BAT0",
    },
    volume = {
        widget = nil,
        text = {
            widget = nil,
        },
        icon = {
            widget = nil,
        },
        update_time = 3631,
        device = "alsa_output.pci-0000_00_1b.0.analog-stereo",
    },
    separator = {
        widget = nil,
        text = "  ",
    },
    systray = {
        widget = nil,
    },
    promptbox = {
        widget = {}, -- One widget per screen
    },
    taglist = {
        widget = {}, -- One per sreen
        buttons = awful.util.table.join(
            awful.button({ }, 1, awful.tag.viewonly),
            awful.button({ modkey }, 1, awful.client.movetotag),
            awful.button({ }, 3, awful.tag.viewtoggle))
    },
    layoutbox = {
        widget = {}, -- One per screen
    },
}


-- Separators
config.widgets.separator.widget = wibox.widget.textbox()
config.widgets.separator.widget:set_markup(config.widgets.separator.text)


-- Date
config.widgets.date_time.widget = wibox.widget.textbox()
vicious.register(
    config.widgets.date_time.widget,
    vicious.widgets.date,
    config.widgets.date_time.format,
    config.widgets.date_time.update_time
)
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
            local today_datespec = os.date("*t") -- Fetch the date of the day
            display_datespec = today_datespec.year * 12 + today_datespec.month - 1 + offset -- Compute date in months to add/remove offset
            display_datespec = (display_datespec % 12 + 1) .. " " .. math.floor(display_datespec / 12) -- Get back date+offset as 'month year'

            -- Get month calendar with week number and week starting on Monday
            local cal = awful.util.pread("cal " .. display_datespec)

            -- Highlight the current day
            if (offset == 0) then
                cal = cal:gsub(
                    "( ?" .. today_datespec.day .. " ?)",
                    string.format(
                        '<span background="%s" foreground="%s">%%1</span>',
                        beautiful.bg_focus,
                        beautiful.fg_urgent
                    )
                )
            end

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
config.widgets.date_time.widget:connect_signal("mouse::enter", function() calendar.display(0) end)
config.widgets.date_time.widget:connect_signal("mouse::leave", calendar.hide)
config.widgets.date_time.widget:buttons(
    awful.util.table.join(
        awful.button({ }, 3, function() calendar.display(-1) end),
        awful.button({ }, 1, function() calendar.display(1) end)
    )
)


-- Battery
-- Create widgets and append them to a layout
config.widgets.battery.widget = wibox.layout.fixed.horizontal()
config.widgets.battery.text.widget = wibox.widget.textbox()
config.widgets.battery.icon.widget = wibox.widget.imagebox()
config.widgets.battery.tooltip = awful.tooltip({})
config.widgets.battery.widget:add(config.widgets.battery.icon.widget)
config.widgets.battery.widget:add(config.widgets.battery.text.widget)
config.widgets.battery.tooltip:add_to_object(config.widgets.battery.widget)
-- Register battery widget
vicious.register(
    config.widgets.battery.text.widget,
    vicious.widgets.bat,
    function (widget, args)
        local state = args[1]
        local current = args[2]
        local time = args[3]
        local result = current .. "%"
        config.widgets.battery.tooltip:set_text("Temps restant : " .. time)

        -- Choose the icon to display
        local icon_dir = "widgets/battery/"
        -- battery discharging
        if state == "−" then
            icon_dir = icon_dir .. "discharging/"
        -- Battery charging or full
        elseif state == "+" or state == "↯" then
            icon_dir = icon_dir .. "charging/"
        -- Battery state unknown
        elseif state == "⌁" then
            icon_dir = icon_dir .. "unknown/"
        end
        -- Set the right icon
        local icon_level = math.floor(tonumber(current)/10)
        config.widgets.battery.icon.widget:set_image(
            beautiful.icons .. icon_dir .. icon_level .. ".png")

        -- Notify user if battery low
        if current < 10 and state == "−" then
            -- Display a new notification only when percentage decreases
            if current < config.widgets.battery.lastwarn then
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
        return result
    end,
    config.widgets.battery.update_time,
    config.widgets.battery.device
)
-- config.widgets.battery.tooltip = (
--     function()
--         local notification = nil

--         local hide_tooltip = function()
--             if notification ~= nil then
--                 naughty.destroy(notification)
--                 notification = nil
--             end
--         end

--         local show_tooltip = function()
--             -- Display calendar with naughty
--             notification = naughty.notify({
--                 text = "Temps restant : " .. config.widgets.battery.time,
--                 timeout = 0, -- No timeout
--                 icon = beautiful.icons .. "widgets/battery/discharging/5.png",
--                 icon_size = config.widgets.wiboxes.top.size,
--                 screen = mouse.screen,
--             })
--         end
--         return {
--             show = show_tooltip,
--             hide = hide_tooltip
--         }
--     end
-- )()
-- config.widgets.battery.widget:connect_signal("mouse::enter", config.widgets.battery.tooltip.show)
-- config.widgets.battery.widget:connect_signal("mouse::leave", config.widgets.battery.tooltip.hide)




-- Volume level
config.widgets.volume.text.widget = wibox.widget.textbox()
config.widgets.volume.icon.widget = wibox.widget.imagebox()
config.widgets.volume.widget = wibox.layout.fixed.horizontal()
config.widgets.volume.widget:add(config.widgets.volume.icon.widget)
config.widgets.volume.widget:add(config.widgets.volume.text.widget)
vicious.register(
    config.widgets.volume.text.widget,
    vicious.contrib.pulse,
    function ( widget, args )
        local state = args[2]
        local level = args[1]
        local result = ""

        local icon_path = "widgets/volume/"        
        if state == "off" then
            icon_path = icon_path .. "mute.png"
            result = "Muted"
        else
            icon_path = icon_path .. math.floor(tonumber(level)/10) .. ".png"
            result = level .. "%"
        end
        config.widgets.volume.icon.widget:set_image(
            beautiful.icons .. icon_path)

        return result
    end,
    config.widgets.volume.update_time,
    config.widgets.volume.device
)
config.widgets.volume.widget:buttons(
    awful.util.table.join(
        awful.button({ }, 1, function() volume.mixer(config.widgets.volume.device) end), -- Normal click
        awful.button({ }, 3, function() volume.toggle(config.widgets.volume.device) end), -- Right click
        awful.button({ }, 5, function() volume.increase(config.widgets.volume.device) end), -- Scroll down
        awful.button({ }, 4, function() volume.decrease(config.widgets.volume.device) end) -- Scroll up
    )
)

-- Systray (nothing fanzy)
config.widgets.systray.widget = wibox.widget.systray()

-- --------------------------------------------------------------------------
-- Per screen widgets
-- --------------------------------------------------------------------------

for s = 1, screen.count() do

    -- This function add the widget what to the layout if it's on screen where or
    -- on all screen (nil)
    local add_widget = function(what, layout, where)
        if where == nil or where == s then
            layout:add(what)
        end
    end

    -- Create the wibox
    -- TODO : iterate over config.widgets.wiboxes to build every desired wiboxes
    config.widgets.wiboxes.top.widget[s] = awful.wibox({
        screen = s,
        position = "top",
        height = config.widgets.wiboxes.top.size,
        bg = config.widgets.wiboxes.top.bg
    })

    -- Create widgets
--    config.widgets.promptbox.widget[s] = awful.widget.prompt()
    config.widgets.promptbox.widget[s] = wibox.widget.textbox()
    config.widgets.layoutbox.widget[s] = awful.widget.layoutbox(s)
    config.widgets.taglist.widget[s] = awful.widget.taglist.new(
        s,
        awful.widget.taglist.filter.all,
        config.widgets.taglist.buttons
    )

    -- Add widgets to the wibox
    -- Widgets that are aligned to the left
    local left_group = wibox.layout.fixed.horizontal()
    add_widget(config.widgets.layoutbox.widget[s], left_group)
    add_widget(config.widgets.taglist.widget[s], left_group)
    add_widget(config.widgets.separator.widget, left_group)
    add_widget(config.widgets.promptbox.widget[s], left_group)

    -- Widgets that are aligned to the right
    local right_group = wibox.layout.fixed.horizontal()
    add_widget(config.widgets.systray.widget, right_group, 1) -- Only on first screen
    add_widget(config.widgets.separator.widget, right_group, 1)
    add_widget(config.widgets.battery.widget, right_group, 1) -- Only on first screen
    add_widget(config.widgets.separator.widget, right_group, 1)
    add_widget(config.widgets.volume.widget, right_group, 1) -- Only on first screen
    add_widget(config.widgets.separator.widget, right_group, 1)
    add_widget(config.widgets.date_time.widget, right_group) -- On all screens

    -- Now bring it all together
    local main_group = wibox.layout.align.horizontal()
    main_group:set_left(left_group)
    main_group:set_right(right_group)

    config.widgets.wiboxes.top.widget[s]:set_widget(main_group)
end

-- Activate shifty now !
local shifty = require("shifty")
shifty.taglist = config.widgets.taglist.widget
shifty.init()
