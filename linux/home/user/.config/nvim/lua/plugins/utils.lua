return {
    -- Sudo write/read
    { "lambdalisue/vim-suda" },

    -- EditorConfig support
    { "gpanders/editorconfig.nvim" },

    -- Multi-cursor: Visual Multi
    {
        "mg979/vim-visual-multi",
        init = function()
            vim.g.VM_maps = {
                ["Add Cursor Up"] = "<C-A-Up>",
                ["Add Cursor Down"] = "<C-A-Down>",
            }
        end,
    },

    -- Disable LazyVim auto-format
    {
        "LazyVim/LazyVim",
        opts = {
            format = { enabled = false },
            formatting = { format_on_save = false },
        },
    },
}
