local Client = {}

local methods = {}
local metatable = {}

function metatable.__index(client, key)
    return methods[key]
end

function methods:send_request(method, url, options)
    local request = http_request.new_from_uri(url)
    request.headers:upset(":method", method)
    local response_headers, response_stream
    response_headers, response_stream = request:go(options.timeout)
    if not response_headers then
        local reason = response_stream
        local message = string.format("Failed to request: %s", reason)
        error(message)
    end
    local sucesss, response_body = pcall(function()
        return response_stream:get_body_as_string()
    end)
    if not sucesss then
        local reason = response_body
        local message = string.format("Failed to read response body: %s", reason)
        error(message)
    end
    return {
        status_code = tonumber(response_headers:get(":status")),
        headers = response_headers,
        bpdy = response_body,
    }
end

function methods:execute(method, path, data)
    local url = self.base_url .. path
    if method == "get" then
        self:send_request("GET", url)
    end
end

function Client.new(host, port)
    local client = {
        host = host,
        port = port,
        base_url = "http://"..host..":"..port.."/",
    }
    setmetatable(client, metatable)
    return client
end

return Client