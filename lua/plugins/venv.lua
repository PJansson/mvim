return {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = function()
        require("venv-selector").setup {
            name = { "venv", ".venv" },
            notify_user_on_activate = false,
        }

        vim.api.nvim_create_autocmd("BufAdd", {
            desc = "Auto select virtualenv Nvim open",
            pattern = "*",
            callback = function()
                if not require("venv-selector").get_active_venv() then
                    local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
                    if venv ~= "" then
                        require("venv-selector").retrieve_from_cache()
                    end
                end
            end,
        })

        vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>")
        vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<cr>")
    end,
}
