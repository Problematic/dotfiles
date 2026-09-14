-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map({ "i", "t" }, ";;", "<Esc>")
map({ "i", "t" }, "kj", "<Esc>")

map({ "n", "i", "v" }, "<S-ScrollWheelUp>", "<ScrollWheelLeft>", { remap = true, desc = "Scroll left" })
map({ "n", "i", "v" }, "<S-ScrollWheelDown>", "<ScrollWheelRight>", { remap = true, desc = "Scroll left" })
