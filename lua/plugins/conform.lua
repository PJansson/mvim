return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
            },
        })
        vim.keymap.set({"n", "v"}, "<leader>cf", conform.format)
    end,
}

