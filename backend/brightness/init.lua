--- Brightness model interface.
-- Interface for brightness management models
-- @module brightness
--
-- @author Alexis BRENON <brenon.alexis+awesome@gmail.com>
local log = require("utils/log")
local submodule = require("utils/submodule")

local import_name = ...

local function missing_implementation(name)
    return function()
        log.error("Brightness: missing implementation for funtion '" .. name .. "'.")
        return nil
    end
end

--- Interface for brightness management model.
-- Contains the full set of functions to override in different implementations
-- @table interface
-- @field set Function to set the brightness value (in percent)
-- @field get Function to get the brightness value (in percent)
-- @field increase Function to increase the brightness value (no parameter required)
-- @field decrease Function to decrease the brightness value (no parameter required)
local interface = {
    set = missing_implementation('set'),
    get = missing_implementation('get'),
    increase = missing_implementation('increase'),
    decrease = missing_implementation('decrease')
}


--- Initial function runned to get supported classes.
-- Find each available implementations and return its constructor
-- @function load_backends
-- @local
-- @return A table containing all constructors
local function load_backends()
    local available_backends = {}
    -- Search for a supported backend
    for _, backend_import_name in ipairs(submodule.fetch_submodules(import_name)) do
        local backend = require(backend_import_name)
        if backend.is_supported() then
            log.info('backlight support : ON (' .. backend.name ..')')
            available_backends[backend.name] = backend.constructor
        end
    end
    return available_backends
end

return load_backends()
