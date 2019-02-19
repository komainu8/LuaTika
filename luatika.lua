local luatika = {}

local metatable = {}
local method = {}

local VERSION = "0.0.1"

local TIKA_PATH = os.getenv("APACHE_TIKA_SERVER_PATH")
local DEFAULT_HOST = "127.0.0.1"
local DEFAULT_PORT = "9998"

function metatable._index(tika, key)
    return method[key]
end

local function apply_options(tika, options)
  local options = options or {}
  local host = options.host or DEFAULT_HOST
  local port = options.port or DEFAULT_PORT

  local path = options.path or TIKA_PATH
end

function method.get_version()
    return VERSION
end

function luatika.new(options)
  local tika = {}
  apply_options(tika, options)
  setmetatable(tika, metatable)
  return tika
end

return luatika
