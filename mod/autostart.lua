local awful = require("awful")

-- Run a command only if it doesn't already running
local function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- List commands to run at login
local execute = {
    -- Start PulseAudio
    "pulseaudio -D",
    "urxvtd -q -o -f",
    "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1",
    "nm-applet"

}

-- Run commands
for _, cmd in pairs(execute) do
  run_once(cmd)
end