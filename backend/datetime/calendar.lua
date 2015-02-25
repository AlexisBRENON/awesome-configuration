local naughty = require("naughty")
local beautiful = require("beautiful")
local awful = require("awful")

local calendar = {}

local notification = nil
local offset = 0

local function hide_calendar()
    if notification ~= nil then
        naughty.destroy(notification)
        notification = nil
        offset = 0
    end
end

local function show_calendar(inc_offset)
    local new_offset = offset + inc_offset
    hide_calendar() -- Usefull if you click on the widget
    offset = new_offset

    -- Get the right month to display
    local today_datespec = os.date("*t") -- Fetch the date of the day
    display_datespec = today_datespec.year * 12 + today_datespec.month - 1 + offset -- Compute date in months to add/remove offset
    display_datespec = (display_datespec % 12 + 1) .. " " .. math.floor(display_datespec / 12) -- Get back date+offset as 'month year'

    -- Get month calendar
    local cal = awful.util.pread("cal " .. display_datespec .. " | sed '/^ *$/d'")

    -- Highlight the current day
    if (offset == 0) then
        cal = cal:gsub(
            "([^a-zA-Z0-9]" .. today_datespec.day .. " )",
            string.format(
                '<span background="%s" foreground="%s">%%1</span>',
                beautiful.bg_focus,
                beautiful.fg_urgent
            )
        )
    end

    local icon_size = (
        (beautiful.widgets and beautiful.widgets.datetime and beautiful.widgets.datetime.calendar and beautiful.widgets.datetime.calendar.icon_size) or
        16
    )
    -- Display calendar with naughty
    notification = naughty.notify({
        text = cal,
        timeout = 0, -- No timeout
        screen = mouse.screen,
        icon = beautiful.icons .. "widgets/date_time/date.png",
        icon_size = icon_size,
        font = beautiful.font_mono,
    })
end

calendar.hide_calendar = hide_calendar
calendar.show_calendar = show_calendar

return calendar

