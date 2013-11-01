-- Lockscreen

local icons = loadrc("icons", "vbe/icons")

xrun("xautolock",
     awful.util.getdir("config") ..
        "/bin/xautolock " ..
        icons.lookup({name = "system-lock-screen", type = "actions" }))

config.keys.global = awful.util.table.join(
   config.keys.global,
   awful.key({}, "XF86ScreenSaver",
             function()
                awful.util.spawn(awful.util.getdir("config") ..
                                 "/bin/locker", false)
             end))

-- Configure DPMS
os.execute("xset dpms 360 720 1200")
