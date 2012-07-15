Vincent Bernat's awesome configuration
--------------------------------------

This is my [awesome](http://awesome.naquadah.org) configuration. It
does not exactly feature the same keybindings as the default
configuration. I don't recommend using it by you can pick anything you
need in it.

I rely on machine hostname for some configuration parts (see
`rc/start.lua`) for the most important part.

Here some of the things you may be interested in:

 - It is modular. I am using `config` as a table to pass different
   things between "modules".

 - In `rc/xrun.lua`, there is a `xrun` function which runs a program
   only if it is not already running. Instead of relying on tools like
   `ps`, it looks at the list of awesome clients and at the list of
   connected clients with `xwininfo`. Seems reliable.

 - I use a light transparency effect to tell if a window has the focus
   or not. It needs a composite manager.

 - I use a Python script `bin/build-wallpaper` to build the wallpaper
   to be displayed. There is a random selection and it works with
   multihead setup. It seems that classic tools are now able to change
   the wallpaper per screen and therefore, the script may seem a bit
   useless but I keep it.

 - I am using `xautolock` + `i3lock` as a screensaver. Nothing fancy
   but I reuse the wallpaper built above. A notification is sent 10
   seconds before starting.

 - In `rc/apparance.lua`, you may be interested by the way I configure
   GTK2 and GTK3 to have an unified look. It works and it does not
   need `gnome-control-center`.

 - I have rebuilt my own implementation of the Quake console in
   `lib/quake.lua`. The common ones didn't like when awesome was
   restarted.

 - I am using notifications when changing volume or brightness. I am
   also using notifications to change xrandr setup. This is pretty
   cool. Notifications are also used to interface with `kbdd` (tool to
   change keybord layout).
 
 - I am sharing tags between screen with
   [sharetags](http://awesome.naquadah.org/wiki/Shared_tags). I am
   also giving names to tags: I access them with something like
   `config.tags.emacs`. I need to try out shifty.

 - Keybindings are "autodocumented". See `lib/keydoc.lua` to see how
   this works. The list of key bindings can be accessed with Mod4 +
   F1.
   
 - On the debug front, I am quite happy with `dbg()` in
   `rc/debug.lua`.

Things in `lib/` are meant to be reused. I am using my own `loadrc()`
function to load modules and therefore, I prefix my modules with
`vbe/`. Before reusing a module, you may want to change this.
