return {
    "echasnovski/mini.starter",
    config = function()
        local starter = require("mini.starter")
        starter.setup({
            header = "",
            items = {
                starter.sections.recent_files(5, false, false),
                {
                    { action = "Telescope file_browser", name = "Browser",   section = "Telescope" },
                    { action = "Telescope find_files",   name = "Files",     section = "Telescope" },
                    { action = "Telescope live_grep",    name = "Grep",      section = "Telescope" },
                    { action = "Telescope projects",     name = "Projects",  section = "Telescope" },
                },
                starter.sections.builtin_actions(),
            },
            footer = ""
        })
    end,
}
