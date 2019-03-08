local luaunit = require("luaunit")
local luatika = require("luatika")

local tika = luatika.new()

TestLuaTika = {}

function TestLuaTika:test_get_version_of_luatika()
  luaunit.assert_equals(tika:get_version(), "0.0.1")
end

function TestLuaTika:test_command_hello()
  tika:start_server()
  luaunit.assert_equals(tika:send_request("HELLO"), "0.0.1")
  tika.stop_server()
end
-- function TestLuaTika:test_version()
--   local callback = function(session)
--     luaunit.assert_equals(session:version(), "1.19.1")
--   end
--   tika:start_session(callback)
-- end
