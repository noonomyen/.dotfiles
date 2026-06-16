-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts_silent = { noremap = true, silent = true }

-- Ctrl+Up/Down: move 4 lines
map("n", "<C-Up>", "4k", opts_silent)
map("n", "<C-Down>", "4j", opts_silent)
map("v", "<C-Up>", "4k", opts_silent)
map("v", "<C-Down>", "4j", opts_silent)
map("i", "<C-Up>", "<C-o>4k", opts_silent)
map("i", "<C-Down>", "<C-o>4j", opts_silent)

-- Ctrl+Left/Right: word motions
map({ "n", "v" }, "<C-Left>", "b", opts_silent)
map({ "n", "v" }, "<C-Right>", "w", opts_silent)

-- Ctrl+Backspace in insert mode
map("i", "<C-BS>", "<C-w>", opts_silent)
map("i", "<C-h>", "<C-w>", opts_silent) -- fallback for terminals

-- Ctrl+Shift+Left/Right: select word
map("n", "<C-S-Left>", "vB", { noremap = true, silent = true })
map("n", "<C-S-Right>", "vE", { noremap = true, silent = true })

-- Ctrl+Shift+Up/Down: select 4 lines
map("n", "<C-S-Up>", "V4k", opts_silent) -- normal mode: start visual selection and go up
map("n", "<C-S-Down>", "V4j", opts_silent) -- normal mode: start visual selection and go down
map("v", "<C-S-Up>", "4k", opts_silent) -- visual mode: extend selection up
map("v", "<C-S-Down>", "4j", opts_silent) -- visual mode: extend selection down
map("i", "<C-S-Up>", "<Esc>V4k", opts_silent) -- insert mode: exit insert, select 4 lines up
map("i", "<C-S-Down>", "<Esc>V4j", opts_silent) -- insert mode: exit insert, select 4 lines down

-- Ctrl+Alt+Left/Right = Begin/End of line

map("n", "<C-A-Left>", "^", opts_silent) -- Move to first non-whitespace character of the line
map("n", "<C-A-Right>", "$", opts_silent) -- Move to end of the line
map("v", "<C-A-Left>", "^", opts_silent) -- Extend selection to line start
map("v", "<C-A-Right>", "$", opts_silent) -- Extend selection to line end
map("i", "<C-A-Left>", "<C-o>^", opts_silent) -- Move to start while staying in insert mode
map("i", "<C-A-Right>", "<C-o>$", opts_silent) -- Move to end while staying in insert mode

-- Clear search highlight AND wipe last search register
map("n", "\\\\", function()
    vim.cmd("nohlsearch")
    vim.fn.setreg("/", "") -- clear last search pattern
end, { noremap = true, silent = true })

