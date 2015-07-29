local module = {}

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

module = {
    name = "xbacklight",
    is_supported = is_supported,
    get = get,
    increase = increase,
    decrease = decrease,
    set = set,
}

return module

