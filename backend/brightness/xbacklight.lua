--- XBacklight brightness management.
-- Implementation of a backlight model based on XBacklight
-- @module brightness.xbacklight
--
-- @author Alexis BRENON <brenon.alexis+awesome@gmail.com>
local function get()
    local current_backlight
    local f = io.popen("xbacklight -get")
    if f then
        current_backlight = tonumber(f:read("*all"))
        if type(current_backlight) == "number" then
            current_backlight = math.floor(current_backlight)
        else
            current_backlight = nil
        end
        f:close()
    end
    return current_backlight
end

local function increase(percent)
    if not percent then
        percent = 10
    end
    os.execute('xbacklight -inc ' .. percent)
end

local function decrease(percent)
    if not percent then
        percent = 10
    end
    os.execute('xbacklight -dec ' .. percent)
end

local function set(percent)
    if not percent then
        error('No value given to the backlight')
    end
    os.execute('xbacklight -set ' .. percent)
end

local function is_supported()
    return (get() ~= nil)
end

local function constructor(base_class)
    local instance = nil
    return function()
        if not instance then
            instance = {
                get = get,
                set = set,
                increase = increase,
                decrease = decrease
            }
            setmetatable(instance, base_class)
        else
            log.warn("XBacklight already instanciated. Current implementation doesn't support different instances for different displays.")
        end
        return instance
    end
end


--- Initial module description.
-- Description returned when searching for subclasses
-- @table module
-- @field name Name of the backend/subclass.
-- @field is_supported Function to test if this backlight is supported.
local module = {
    name = "xbacklight",
    is_supported = is_supported,
}

return module

