local Client = require("luatika/client")

local Tika = {}

local methods = {}
local metatable = {}

function metatable.__index(tika, key)
    return methods[key]
end

local DEFAULT_HOST = "127.0.0.1"
local DEFAULT_PORT = "9998"

local function start_server(tika)
    tike.server = Server.new(tika)
    tika.server:start()
end

local function apply_options(tika, options)
    local options = options
    local host = options.host or DEFAULT_HOST
    local port = options.port or DEFAULT_PORT
    tika.client = Client.new(host, port)
end

function Tika.new(options)
    local tika = {}
    apply_options(tika, options)
    setmetatable(tika, metatable)
    return tika
end

return Tika