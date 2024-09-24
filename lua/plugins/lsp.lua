return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "pyright", "ruff" },
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = { ignore = { '*' } },
                    },
                },
            })

            local on_attach = function(client, bufnr)
                if client.name == 'ruff' then
                   client.server_capabilities.hoverProvider = false
                end
            end

            lspconfig.ruff.setup({
                on_attach = on_attach,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    local builtin = require("telescope.builtin")

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

                    vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
                    vim.keymap.set("n", "gI", builtin.lsp_implementations, opts)
                    vim.keymap.set("n", "gr", builtin.lsp_references, opts)
                    vim.keymap.set("n", "gy", builtin.lsp_type_definitions, opts)

                    vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                end,
            })
        end,
    },
}
