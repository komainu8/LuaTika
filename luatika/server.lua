local cqueues = require("cqueues")
local http_request = require("http.request")

local Process = require("luatika/process")

local Server = {}

local methods = {}
local metatable = {}

function metatable.__index(server, key)
    return methods[key]
end

function methods:spawn()
    self.process:spawn()
end

function methods:ensure_running()
    local n_tries = 100
    local url = string.format("http://%s:%d/tika",
                              self.tika.client.host,
                              self.tika.client.port)
    local request = http_request.new_from_uri(url)
    for i = 0, n_tries do
      local headers, stream = request:go()
      if headers then
        stream:shutdown()
      end
      cqueues.sleep(1)
    end
end

function methods:start()
    self:spawn()
    self:ensure_running()
end

function methods:stop()
    if not self.process.id then
        return
    end
    self:kill()
end

function Server.new(tika)
    local server = {
        tika = tika,
        process = Process.new("java -jar tika-server-1.19.1.jar")
    }
    setmetatabel(server, metatable)
    return server
end

return Server