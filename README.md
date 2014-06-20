# My AwsomeWM (3.5) configuration #
This is my [Awesome](http://awesome.naquadah.org) configuration. It is greatly inspired from [Vincent Bernat](https://github.com/vincentbernat/awesome-configuration)'s one.
Here some of the things you may be interested in:
* It is modular
* It displays notifications when changing volume, brightness and Xrandr outputs
* One tag for one app (except terminal)
* Iconic tag name


## Requirements ##
Here is a list of known requirements. As my Awesome install comes over a Debian Testing (Jessie) some requirements are already installed by it.

### Awesome third library ###
* [Shifty](https://github.com/bioe007/awesome-shifty) for tag management
* [Vicious](http://git.sysphere.org/vicious/) for widgets

### Fonts ###
* ttf-dejavu for common text
* [FontAwesome](http://fontawesome.io/) for icons

### Utils ###
* alsa-utils
* pavucontrol

### Default softwares ###
These softs can be configured in the main rc.lua file
* **Terminal** : rxvt-unicode-256color + bash
* **Text editor** : Sublime Text 2
* **Web browser** : Google Chrome (for it's embedded flash player)
* **File browser** : Gnome Commander
* **Office suite** : Libre Office


## TODO : ##
- [ ] Add a custom prompt for [web search](http://awesome.naquadah.org/wiki/Anrxcs_WebSearch_Prompt)
- [ ] Add a keyboard layout change widget
- [ ] Update screenshot with new tags icons
- [x] Move requirements to the README
- [ ] Add link to my versionned bashrc
