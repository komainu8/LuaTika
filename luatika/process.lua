local Process

local methods = {}
local metatable = {}

function metatable.__index(process, key)
    return methods[key]
end

function Process.new(command, arguments)
    local process = {
        command = command,
        arguments = arguments,
    }
    setmetatable(process, metatable)
    return process
end

return Process