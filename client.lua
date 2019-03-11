local Client = {}

local curl = require("cURL")
local metatable = {}
local methods = {}

function metatable.__index(client, key)
  return methods[key]
end

local function send_request(url, http_method)
  local response_code = 0

  if http_method == "GET" then
    send = curl.easy{
      url = url,
      [curl.OPT_VERBOSE] = true,
    }
    send:perform()
    response_code = send:getinfo(curl.INFO_RESPONSE_CODE)
    send:close()
  end
  return response_code
end

function methods:send(command)
  local request_url
  local http_method
  if command == "HELLO" then
    request_url = self.base_url .. "tika"
    http_method = "GET"
  end
  send_request(request_url, http_method)
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
