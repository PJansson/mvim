return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup {
            manual_mode = true,
        }
        vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", {})
    end
}
