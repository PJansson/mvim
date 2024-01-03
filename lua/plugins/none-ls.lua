return {
    {
        "jay-babu/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "stylua", "flake8", "blue", "isort" }
            })
        end
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.flake8,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.blue.with({
                        extra_args = { "--line-length", 120 },
                    }),
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, {})
        end,
    }
}
