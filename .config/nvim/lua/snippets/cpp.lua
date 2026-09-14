local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

-- Dervice class name from filename
local function classname()
  local filename = vim.fn.expand("%:t:r") -- Get the current file name without extension
  return filename
end

ls.add_snippets("cpp", {
  s("class", {
    f(function()
      return "class " .. classname() .. " {"
    end),
    i(0, "\npublic\n  "),
    f(function()
      return { "", "};" }
    end),
  }),
})
