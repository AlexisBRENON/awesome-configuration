local client_wrapper = require('backend/client_wrapper')

local module = {}

function module.load(config)
    local mouse = {}
    mouse.global = {}
    mouse.client = {
        {{        }, 1, client_wrapper.focus, nil, "Give focus to window"},
        {{ modkey }, 1, client_wrapper.move, nil, "Move window in floating layout"},
        {{ modkey }, 3, client_wrapper.resize, nil, "Resize window"}
    }

    return mouse
end

return module
