local Client = require("client")
local Server = require("server")

local luatika = {}

local metatable = {}
local methods = {}

local VERSION = "0.0.1"

local TIKA_PATH = os.getenv("APACHE_TIKA_SERVER_PATH")
local DEFAULT_HOST = "127.0.0.1"
local DEFAULT_PORT = "9998"

function metatable.__index(tika, key)
    return methods[key]
end

local function apply_options(tika, options)
  local options = options or {}
  local host = options.host or DEFAULT_HOST
  local port = options.port or DEFAULT_PORT
  tika.client = Client.new(host, port)

  local path = options.path or TIKA_PATH
  tika.server = Server.new(path)
end

function methods:get_version()
  return VERSION
end

function methods:start_server()
  return self.server:start(TIKA_PATH)
end

function methods:stop_server()
  return self.server:stop()
end

function methods:send_request(command)
  return self.client:send(command)
end

function luatika.new(options)
  local tika = {}
  apply_options(tika, options)
  setmetatable(tika, metatable)
  return tika
end

return luatika
