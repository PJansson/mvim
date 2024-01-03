return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope-file-browser.nvim"
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local actions = require("telescope.actions")
            local action_layout = require("telescope.actions.layout")

	    vim.api.nvim_create_autocmd("FileType", {
                pattern = "TelescopeResults",
                callback = function(ctx)
                    vim.api.nvim_buf_call(ctx.buf, function()
                        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
                    end)
                end,
            })

            local function filenameFirst(_, path)
                local tail = vim.fs.basename(path)
                local parent = vim.fs.dirname(path)
                if parent == "." then return tail end
                return string.format("%s\t\t%s", tail, parent)
            end

            require("telescope").setup({
                pickers = {
                    find_files = {
                        path_display = filenameFirst,
                    }
                },
                defaults = {
                    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<M-p>"] = action_layout.toggle_preview
                        },
                        n = {
                            ["<M-p>"] = action_layout.toggle_preview
                        },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    ["file_browser"] = {
                        grouped = true,
                        previewer = false,
                        respect_gitignore = true,
                        sorting_strategy = "ascending",
                        hijack_netrw = true,
                    },
                },
            })

            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("file_browser")

            vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", {})
            vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", {})
            vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", {})
            vim.keymap.set("n", "<leader>fB", ":Telescope buffers<CR>", {})

        end,
    },
}
