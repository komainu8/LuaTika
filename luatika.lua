local luatika = {}

local metatable = {}
local method = {}

local VERSION = "0.0.1"

local TIKA_PATH = ""
local DEFAULT_HOST = "127.0.0.1"
local DEFAULT_PORT = "9998"

function metatable._index(tika, key)
    return method[key]
end

function luatika.new()
  local tika = {}
  setmetatable(tika, metatable)
  return tika
end

return luatika
