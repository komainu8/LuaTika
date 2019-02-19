local Client = {}

local metatable = {}
local methods = {}

function metatable.__index(client, key)
  return methods[key]
end

function Client.new(host, port)
  local client = {
    host = host,
    port = port,
    base_url = "http://" ..host.. ":" ..port.. "/",
  }
  setmetatable(client, metatable)
  return client
end

return Client
