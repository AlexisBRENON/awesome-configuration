# My AwesomeWM (3.5) configuration #
This is my [Awesome](http://awesome.naquadah.org) configuration. The first one was
based on the [Vincent Bernat](https://github.com/vincentbernat/awesome-configuration)'s one, but since time, it greatly diverged !

![My screenshot](https://raw.githubusercontent.com/AlexisBRENON/awesome-configuration/master/screenshot.jpg)

You can find [my wallpapers on my Dropbox](https://www.dropbox.com/sh/sz7xcn7ygpxixoz/AAA_jpIMzlLuUy4fwD5S4A0Ma?dl=0). One is choose randomly at each awesome start. (Sorry for the missing credits, most of them come from [deviantart](http://www.deviantart.com/), [Hubble website](http://hubblesite.org/gallery/wallpaper/), [Ubuntu wallpapers](http://www.omgubuntu.co.uk/category/wallpaper), etc...)

Here are some of the things you may be interested in:
* It is modular (see below)
* It display notifications when changing ~~volume~~, brightness, Xrandr outputs and keyboard layouts
* Each app has its tag (except for terminal, and some uncommon app)
* Tag names are iconic thanks to FontAwesome (see below)

## Requirements ##
Here is a list of known requirements on Arch Linux. Please, send me a message if you find there is
one missing !

### Awesome third library ###
* [Shifty](https://github.com/bioe007/awesome-shifty) for tag management
* [Vicious](http://git.sysphere.org/vicious/) for widgets

### Fonts ###
* ttf-dejavu for common text
* [FontAwesome](http://fontawesome.io/) for icons

### Utils ###
* pulseaudio and pavucontrol (audio control)
* xbacklight (laptop backlight control)
* NetworkManager and nm-applet (network control)
* ImageMagick (screenshot ability)

### Default softwares ###
* **Terminal** : rxvt-unicode-256color ~~+ [bash](https://github.com/AlexisBRENON/dotfiles/blob/master/bash.bashrc)~~ [zsh + oh my zsh](https://github.com/AlexisBRENON/dotfiles/blob/master/bash/zshrc)
* **Text editor** : vim + [Vundle](https://github.com/AlexisBRENON/dotfiles/blob/master/vimrc)
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
- [x] Clean up the mod/ folder and refactor code to avoid too much global data
- [ ] Create a network widget instead of using a third party applet
- [ ] Make Shifty an optional requirement
- [ ] Use multi-threading to increase configuration loading and execution

# How to use it ?

As said earlier, this configuration is modular. There are many files that you can customise if
necessary. For a simple use, you only have to change the config/\*.lua files. _Let's explain a little
more !_

## The architecture

The configuration is mainly based on three parts :

- the `backend/` folder is the folder which contains most of the code executed **during awesome run**. It's
  in this folder that you can find every widgets backend code for update ;
- the `config/` folder contains many files which mainly consist in lua tables definition. **There is
  no Awesome related code in this folder !** If necessary, use an awesome wrapper in
  `backend/awesome_wrapper/` and
  reference this wrapper. This way, configuration files haven't to be updated if Awesome API change
  ;
- the `builder/` folder contains the code ran at Awesome start. As its name let's suppose, this code
  will build and initialize any components and widgets.

## Customize it

All these three parts can be modified depending on you needs :

 - **for a quick usage, you can use it "as is"**, and most of it must work... Else you only have to change the `config/\*.lua` files to reflect
   your install (battery ID, audio output, applications, etc.) ;
 - if you need more control over the widgets or whatever, you will have to go deeper in the code. If
   you only need to customize the existing widgets, take a look into the `backend/` folder. In the Lua
   files there are the update/notify functions used to display what you want on the widgets. Don't
   change existing functions. **Feel free to write new functions for your needs** and reference it
   in the config files ! That's it, your widget will display what you want ;
 - for the moment all widgets are not implemented, and they will never be, because there is an
   infinity of possible widgets. To add a widget type, add its building code in the
   `builder/widgets/` folders, and the backend code in the `backend/` folder. **See other widgets, to
   see how `config/`, `builder/` and `backend/` work together !**

