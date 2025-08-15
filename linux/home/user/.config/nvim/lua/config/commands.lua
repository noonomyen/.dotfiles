-- Extra user commands

-- Sudo save
vim.api.nvim_create_user_command("W", function()
    vim.cmd("SudaWrite")
end, {})

-- Convert fileformat to DOS (CRLF)
vim.api.nvim_create_user_command("FFDos", function()
    vim.opt.fileformat = "dos"
    vim.cmd("update")
    print("File format set to DOS (CRLF).")
end, {})

-- Convert fileformat to UNIX (LF)
vim.api.nvim_create_user_command("FFUnix", function()
    vim.opt.fileformat = "unix"
    vim.cmd("update")
    print("File format set to UNIX (LF).")
end, {})
