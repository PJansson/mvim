return {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    branch = "regexp",
    config = function()
        require("venv-selector").setup {
            name = { "venv", ".venv" },
        }

        vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>")
    end,
}
