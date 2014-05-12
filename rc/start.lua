-- Start idempotent commands
local execute = {
  -- Start PulseAudio
  "pulseaudio --check || pulseaudio -D",
  "xset -b",	-- Disable bell
  "(urxvtd &)",
  -- Read resources
  -- "xrdb -merge " .. awful.util.getdir("config") .. "/Xresources",
  -- Default browser
  "xdg-mime default " .. config.browser .. ".desktop " ..
  "x-scheme-handler/http " ..
  "x-scheme-handler/https " ..
  "text/html",
  -- Default MIME types
  "xdg-mime default evince.desktop application/pdf",
  "xdg-mime default gpicview.desktop image/png image/x-apple-ios-png image/jpeg image/jpg image/gif"
}
os.execute(table.concat(execute, ";"))

-- Spawn various X programs
xrun("polkit-gnome-authentication-agent-1",
"/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")

xrun("NetworkManager Applet", "nm-applet")