-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.ai_cmp = false

vim.opt.termguicolors = true

vim.opt.colorcolumn = "120"

-- y/p use system clipboard; Neovim auto-uses OSC 52 over SSH (Windows Terminal supports it)
vim.opt.clipboard = "unnamedplus"
