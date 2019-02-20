local Client = {}

local curl = require("cURL")
local metatable = {}
local methods = {}

function metatable.__index(client, key)
  return methods[key]
end

local function send_request(url)
  send = culr.easy{
    url = url,
    [curl.OPT_VERBOSE] = true,
  }
  send:perform()
  send:close()
end

function send(command)
  send_request(command)
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
