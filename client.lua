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

function methods:send(command)
  local request_url
  if command == "HELLO" then
    request_url = self.base_url .. "tika"
  end
  send_request(request_url)
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
