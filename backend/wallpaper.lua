local lfs = require("lfs")

local wallpaper = {}

local function init(path)
    wallpaper.images = {}
    -- Fetch all available wallpapers
    for image in lfs.dir(path) do
        if image:match("%.jpg$") then
            table.insert(wallpaper.images, path .. '/' .. image)
        end
    end

    --Fetch one randomly
    math.randomseed(os.time())
    wallpaper.index = math.random(1, #wallpaper.images)
end

local function get()
    return wallpaper.images[wallpaper.index]
end

wallpaper.init = init
wallpaper.get = get

return wallpaper
