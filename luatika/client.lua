local Client = {}

local methods = {}
local metatable = {}

function metatable.__index(client, key)
    return methods[key]
end

function Client.new(host, port)
    local client = {
        host = host,
        port = port,
    }
    setmetatable(client, metatable)
    return client
end

return Client