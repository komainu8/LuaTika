local luaunit = require("luaunit")
local luatika = require("luatika")
local tika = luatika.tika.new()

TestLuaTika = {}

function TestLuaTika:test_version()
  local callback = function(session)
    luaunit.assert_equals(session:version(), "1.19.1")
  end
  tika:start_session(callback)
end