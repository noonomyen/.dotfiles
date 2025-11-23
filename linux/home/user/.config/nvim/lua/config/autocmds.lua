-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Send only yank (not delete) to clipboard
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("WinClipYank", { clear = true }),
    callback = function()
        -- Only when operator is yank
        if vim.v.event.operator == "y" then
            pcall(function()
                local yanked = vim.fn.getreg("0") -- last yanked text
                if #yanked > 0 then
                    -- Clipboard input path
                    -- CB_PATH = "/mnt/c/Windows/System32/clip.exe"
                    -- CB_PATH = "/usr/bin/xsel --input --clipboard"
                    CB_PATH = "/usr/bin/wl-copy"
                    vim.fn.system({ CB_PATH }, yanked)
                end
            end)
        end
    end,
})
