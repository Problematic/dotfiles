return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- ruff_organize_imports sorts the import block (fixes Ruff I001 on save)
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    },
  },
}
