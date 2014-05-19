-- Change wallpaper
config.wallpaper = {}
config.wallpaper.directory = awful.util.getdir("config") .. "/wallpapers/"
config.wallpaper.current = awful.util.getdir("cache") .. "/current-wallpaper.png"

-- Find all avalaible wallpapers
wallpapers = awful.util.pread("ls -1 " .. config.wallpaper.directory)
-- Fetch one randomly
local sep = "\n"
local wallpapers_list = {wallpapers:match((wallpapers:gsub("[^"..sep.."]*"..sep, "([^"..sep.."]*)"..sep)))}
math.randomseed(os.time())
local wallpaper_idx = math.random(1, #wallpapers_list)
local wallpaper = wallpapers_list[wallpaper_idx]

-- Create a new symbolic link to the selected wallpaper
os.execute(
  "rm -f " .. config.wallpaper.current .. ";" ..
  "ln -s " .. config.wallpaper.directory .. wallpaper .. " " .. config.wallpaper.current
)

