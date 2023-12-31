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

            require("telescope").setup({
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
