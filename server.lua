local Server = {}

local Process = require("process")

local metatable = {}
local methods = {}

function metatable.__index(server, key)
    return methods[key]
end

function methods:spawn()
    self.process:spawn()
end

function methods:start()
    self:spawn()
end

function methods:stop()
    if not self.process.id then
        return
    end
    self.process:kill()
end

function Server.new(path)
    local server = {
        process = Process.new("java -jar " .. path)
    }
    setmetatable(server, metatable)
    return server
end

return Server
