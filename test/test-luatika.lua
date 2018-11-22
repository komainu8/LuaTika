local luaunit = require("luaunit")
local luatika = require("luatika")

TestLuaTika = {}

function TestLuaTika:test_version()
    luaunit.assert_equals(luatika.VERSION, "0.0.1")
end