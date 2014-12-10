local shifty = require("shifty")
local awful = {}
awful.util = require("awful.util")

shifty.config.apps = {
  {
    match = {
      config.application.web_browser.matching
    },
    tag = "",
  },
  {
    match = {
      config.application.file_browser.matching
    },
    tag = "",
  },
  {
    match = {
      config.application.terminal.matching
    },
    slave = true,
  },
  {
    match = {
      config.application.image_editor.matching
    },
    tag = "",
  },
  {
    match = {
      config.application.video_player.matching
    },
    tag = "",
  },
  {
    match = {
      config.application.text_editor.matching
    },
    tag = "",
  },
  {
    match = {
      "TeamViewer%.exe"
    },
    tag = ""
  },
  {
    match = {
      "libreoffice%-writer"
    },
    tag = "",
  },
  {
    match = {
      "libreoffice%-impress"
    },
    tag = "",
  },
  {
    match = {
      "libreoffice%-calc"
    },
    tag = "",
  },
  {
    match = {
      type = {
        "dialog",
        "splash",
      }
    },
    float = true,
    intrusive = true,
  },
  {
    match = {""},
    buttons = config.mouse.client,
  }
}
