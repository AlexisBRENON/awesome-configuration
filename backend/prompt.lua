local awful = require('awful')
local naughty = require('naughty')

local prompt = {}

function prompt.calculator()
    awful.prompt.run(
    {prompt = " = "},
    prompt.prompts[mouse.screen],
    function (expr)
        local result = awful.util.eval("return (" .. expr .. ")")
        naughty.notify({
            text = expr .. " = " .. result,
            timeout = 0
        })
    end,
    nil,
    awful.util.getdir("cache") .. "/calculator_history"
    )
end

function prompt.execute()
    awful.prompt.run(
    {prompt = "Run: "},
    prompt.prompts[mouse.screen],
    awful.util.spawn,
    awful.completion.shell,
    awful.util.getdir("cache") .. "/execute_history"
    )
end

function prompt.web_search()
    awful.prompt.run(
    {prompt = "Web search: "},
    prompt.prompts[mouse.screen],
    function (command)
        awful.util.spawn(
        config.applications.web_browser .. " 'http://yubnub.org/parser/parse?command=" .. command .. "'")
    end,
    nil,
    awful.util.getdir("cache") .. "/search_history"
    )
end

function prompt.set_prompts(prompts)
    prompt.prompts = prompts
end

return prompt

