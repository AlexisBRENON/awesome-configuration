local awful = require("awful")

-- Change wallpaper
local wallpaper_directory = awful.util.getdir("config") .. "/theme/wallpapers/"
config.wallpaper = awful.util.getdir("cache") .. "/current-wallpaper.png"

-- Find all avalaible wallpapers
wallpapers = awful.util.pread("ls -1 " .. wallpaper_directory)
local sep = "\n"
local wallpapers_list = {wallpapers:match((wallpapers:gsub("[^"..sep.."]*"..sep, "([^"..sep.."]*)"..sep)))}

-- Fetch one randomly
math.randomseed(os.time())
local wallpaper_idx = math.random(1, #wallpapers_list)
local wallpaper = wallpapers_list[wallpaper_idx]

-- Create a new symbolic link to the selected wallpaper
os.execute(
  "rm -f " .. config.wallpaper .. ";" ..
  "ln -s " .. wallpaper_directory .. wallpaper .. " " .. config.wallpaper
)

