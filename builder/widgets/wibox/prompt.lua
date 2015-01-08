local wibox = require('wibox')

local prompt_args = config.widget.prompt
for s = prompt_args.screen or 1, prompt_args.screen or screen.count() do
    prompt_args.widget[s] = wibox.widget.textbox()
end
