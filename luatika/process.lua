local unix = require("unix")

local Process = {}

local methods = {}
local metatable = {}

function metatable.__index(process, key)
    return methods[key]
end

function methods:spawn()
    local pid = unix.fork()
    if pid == 0 then
        local args = { self.command }
        local i, arg
        for i, arg in ipairs(self.arguments) do
            table.insert(args, arg)
        end
        unix.setsid()
        unix.execvp(self.command, args)
        unix._exit(1)
    end
    self.id = pid
end

function Process.new(command, arguments)
    local process = {
        id = nil,
        command = command,
        arguments = arguments or {}
    }
    setmetatable(process, metatable)
    return process
end

return Process