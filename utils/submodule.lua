-- Some common function used to handles submodules
local lfs = require("lfs")
local log = require("utils/log")

local module = {}

function module.fetch_submodules(current_module_name)
    submodules = {}
    -- Look at all enitities in the current directory
    for entity in lfs.dir(current_module_name) do
        -- Left aside :
        --   hidden files
        --   the current lua file
        if (not string.match(entity, "^%..*")) and
            entity ~= 'init.lua' then
            -- Remove the lua extension useless for import
            entity = entity:gsub('%.lua', '')
            table.insert(submodules, current_module_name .. "/" .. entity)
        end
    end

    return submodules
end

function module.get_super_import_name(current_module_name)
    super_import_name = string.match(
        current_module_name,
        "^(.*)/.*$")
    if not package.loaded[super_import_name] then
        error("Generated super_import_name isn't already loaded. This is impossible !")
    end
    return super_import_name
end

function module.get_module_name(import_name)
    return string.match(import_name, "[^/]*$")
end

return module
