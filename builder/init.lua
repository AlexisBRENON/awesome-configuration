local builder = {}

function builder.build(config)
    require('builder/appearance').build(config.theme)
    require('builder/tags').build(config.tags)
    require('builder/widgets').build(config.widgets)
end

return builder
