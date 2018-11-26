local Tika = {}

local methods = {}
local metatable = {}

function metatable.__index(tika, key)
    return methods[key]
end

function Tika.new(options)
    local tika = {}
    setmetatable(tika, metatable)
    return tika
end

return Tika