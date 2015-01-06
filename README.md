# My AwsomeWM (3.5) configuration #
This is my [Awesome](http://awesome.naquadah.org) configuration. It is greatly inspired from [Vincent Bernat](https://github.com/vincentbernat/awesome-configuration)'s one, but since time, I hope that it greatly diverged also !

![My screenshot](https://raw.githubusercontent.com/AlexisBRENON/awesome-configuration/master/screenshot.jpg)

You can find [my wallpapers on my Dropbox](https://www.dropbox.com/sh/sz7xcn7ygpxixoz/AAA_jpIMzlLuUy4fwD5S4A0Ma?dl=0). One is choose randomly at each awesome start. (Sorry for the missing credits, most of them come from [deviantart](http://www.deviantart.com/), [Hubble website](http://hubblesite.org/gallery/wallpaper/), [Ubuntu wallpapers](http://www.omgubuntu.co.uk/category/wallpaper), etc...)

Here are some of the things you may be interested in:
* It is modular (see the mod/ folder)
* It display notifications when changing ~~volume~~, brightness and Xrandr outputs
* Each app has its tag (except for terminal, and some uncommon app)
* Tag names are iconic thanks to FontAwesome (see below)

## Requirements ##
Here is a list of known requirements on Arch Linux

### Awesome third library ###
* [Shifty](https://github.com/bioe007/awesome-shifty) for tag management
* [Vicious](http://git.sysphere.org/vicious/) for widgets

### Fonts ###
* ttf-dejavu for common text
* [FontAwesome](http://fontawesome.io/) for icons

### Utils ###
* pulseaudio
* pavucontrol
* xbacklight
* wicd and wicd-gtk
* rfkill
* ImageMagick

### Default softwares ###
These softs can be configured in the main rc.lua file
* **Terminal** : rxvt-unicode-256color ~~+ [bash](https://github.com/AlexisBRENON/dotfiles/blob/master/bash.bashrc)~~ [zsh + oh my zsh](https://github.com/AlexisBRENON/dotfiles/blob/master/bash/zshrc)
* **Text editor** : ~~Sublime Text 2~~ Vim
* **Web browser** : Google Chrome (for it's embedded flash player)
* ~~**File browser** : Gnome Commander~~
* **Office suite** : Libre Office


## TODO : ##
- [x] Add a custom prompt for [web search](http://awesome.naquadah.org/wiki/Anrxcs_WebSearch_Prompt)
- [x] Update screenshot with new tags icons [21/06/2014]
- [x] Move requirements to the README
- [x] Add link to my versionned bashrc
- [x] Restore notifications
- [x] Add a keyboard layout change widget
- [x] Fix the volume keys, layout change and sreenshot key issues ~~(the three of them are linked)~~
- [ ] Create a network widget instead of using a third party applet
- [ ] Clean up the mod/ folder and refactor code to avoid too much global data
