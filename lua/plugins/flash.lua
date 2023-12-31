return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        enabled = false,
      }
    },
    prompt = {
      enabled = false,
    }
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
  },
}
