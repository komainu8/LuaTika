local Process = require("luatika/process")

local Server = {}

local methods = {}
local metatable = {}

function metatable.__index(server, key)
    return methods[key]
end

function methods:spawn()
    self.process:spawn()
end

function methods:start()
    self:spawn()
    self:ensure_running()
end

function Server.new()
    local server = {
        process = Process.new("java -jar tika-server-1.19.1.jar")
    }
    setmetatabel(server, metatable)
    return server
end

return Server