-- Extra neotest keymaps: watch-on-save + verbose/pdb runs.
-- Merges with LazyVim's test.core spec (keys are combined, not replaced).
return {
  "nvim-neotest/neotest",
  keys = {
    {
      "<leader>tw",
      function()
        require("neotest").watch.toggle()
      end,
      desc = "Watch nearest (toggle)",
    },
    {
      "<leader>tW",
      function()
        require("neotest").watch.toggle(vim.fn.expand("%"))
      end,
      desc = "Watch file (toggle)",
    },
    {
      "<leader>tv",
      function()
        require("neotest").run.run({ extra_args = { "-s" } })
      end,
      desc = "Run nearest (verbose, -s)",
    },
    {
      "<leader>tp",
      function()
        require("neotest").run.run({ extra_args = { "--pdb" } })
      end,
      desc = "Run nearest (--pdb on fail)",
    },
  },
}
