local module = {}

function module.load(config)
    local tags = {}

    -- Init (without any name)
    tags.tags["\n"] = {
        position = 0,
        init = true,
    }
    -- Web browser
    tags.tags[""] = {
        position = 1,
    }
    -- File browser
    tags.tags[""] = {
        position = 2,
    }
    -- text editor / code
    tags.tags[""] = {
        position = 3,
    }
    -- Gimp / image management
    tags.tags[""] = {
        position = 4,
    }
    -- VLC / video
    tags.tags[""] = {
        position = 5,
    }
    -- Office calc
    tags.tags[""] = {
        position = 6,
    }
    -- Office writer
    tags.tags[""] = {
        position = 6,
    }
    -- Office impress
    tags.tags[""] = {
        position = 6,
    }
    -- Teamviewer
    tags.tags[""] = {
        position = 9,
    }

    tags.defaults = {
        layout = 1,
        persist = false,
        floatBars = true,
        guess_name = true,
        guess_position = true,
        exclusive = true,
    }

    tags.layouts = {
        'tile',
        'tile.left',
        'tile.bottom',
        'magnifier',
    }

    return tags
end

return module

