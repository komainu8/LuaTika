local Client = {}

local curl = require("cURL")
local metatable = {}
local methods = {}

function metatable.__index(client, key)
  return methods[key]
end

local function send_request(url, http_method, path)
  local response_code = 0

  if http_method == "GET" then
    send = curl.easy{
      url = url,
      [curl.OPT_VERBOSE] = true,
    }
    send:perform()
    response_code = send:getinfo(curl.INFO_RESPONSE_CODE)
    send:close()
  elseif http_method == "PUT" then
    local file = io.open(path, "w+b")
    curl.setopt(curl.OPT_READFUNCTION,
      function() print("test") end)
    curl.setopt(curl.OPT_UPLOAD, 1)
    curl.setopt(curl.OPT_PUT, 1)
    curl.setopt(curl.OPT_URL, url)
    curl.setopt(curl.OPT_READDATA, file)
    curl.setopt(curl.OPT_INFILESIZE_LARGE, file:seek("end"))
    curl.perform()
  end
  return response_code
end

function methods:send(command, path)
  local request_url
  local http_method

  if command == "HELLO" then
    request_url = self.base_url .. "tika"
    http_method = "GET"
  elseif command == "META" then
    request_url = self.base_url .. "meta"
    http_method = "PUT"
  end
  send_request(request_url, http_method, path)
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
