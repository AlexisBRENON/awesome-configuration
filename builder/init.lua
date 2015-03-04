local builder = {}

function builder.build(config)
    require('builder/keyboard').build(config.keyboard)
    require('builder/appearance').build(config.theme)
    require('builder/tags').build(config.tags)
    require('builder/rules').build(config.rules)
    require('builder/widgets').build(config.widgets, config.main.builder)
    require('builder/keys').build(config.keys)
end

return builder
