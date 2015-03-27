local submodule = require("utils/submodule")
local datetime = {}

for _, module in ipairs(submodule.fetch_submodules(...)) do
    datetime[submodule.get_module_name(module)] = require(module)
end

return datetime

