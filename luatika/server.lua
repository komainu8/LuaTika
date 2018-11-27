local Server = {}

local methods = {}
local metatable = {}

function metatable.__index(server, key)
    return methods[key]
end

function Server.new()
    local server = {}
    setmetatabel(server, metatable)
    return server
end

return Server