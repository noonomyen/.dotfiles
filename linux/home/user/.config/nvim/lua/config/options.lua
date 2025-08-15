-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Basic editor options
local opt = vim.opt

opt.mouse = "a" -- enable mouse
opt.number = true -- absolute line numbers
opt.relativenumber = false -- not relative to cursor
opt.encoding = "utf-8" -- internal encoding
opt.expandtab = true -- tabs -> spaces
opt.shiftwidth = 4 -- indentation size
opt.tabstop = 4 -- visual width of a tab
opt.belloff = "all" -- disable bell

-- Disable auto-format on save (LazyVim specific)
vim.g.autoformat = false

-- Editorconfig
vim.g.editorconfig = true

-- Do not use system clipboard (let terminal handle it)
vim.opt.clipboard = ""
