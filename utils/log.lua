local io = require("io")
local log = {
    output = io.stderr,
    levels = {
        NONE = 0,
        ERROR = 1,
        WARNING = 2,
        INFO = 3,
        DEBUG = 4,
        ALL = 9
    }
}

local function header(level)
    if level == log.levels.ERROR then
        result = "## ERROR ## "
    elseif level == log.levels.WARNING then
        result = "## WARN  ## "
    elseif level == log.levels.INFO then
        result = "## INFO  ## "
    elseif level == log.levels.DEBUG then
        result = "## DEBUG ## "
    end
    return result
end

function log.write(level, ...)
    if level <= log.level then
        log.output:write(header(level) .. ... .. "\n")
    end
end

function log.set_output(output)
    if type(output) == "string" then
        log.output = io.open(output, "a")
    elseif io.type(output) == "file" then
        log.output = output
    end
end

log.level = log.levels.NONE
log.debug = function(...) log.write(log.levels.DEBUG, ...) end
log.info = function(...) log.write(log.levels.INFO, ...) end
log.warning = function(...) log.write(log.levels.WARNING, ...) end
log.error = function(...) log.write(log.levels.ERROR, ...) end

return log
