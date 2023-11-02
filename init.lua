vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vim.o.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.scrolloff = 10

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  {
    "echasnovski/mini.nvim",
    version = false,
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'L3MON4D3/LuaSnip'
    },
  },

  {
    "ahmedkhalf/project.nvim",
    manual_mode = true,
  },

  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = false
        }
      },
      prompt = {
        prefix = { { " F " } },
      }
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  { "shortcuts/no-neck-pain.nvim", version = "*" }
})


require('no-neck-pain').setup({})
require("venv-selector").setup({
  name = ".venv",
})
vim.keymap.set('n', '<leader>vs', '<cmd>:VenvSelect<cr>', {})
vim.keymap.set('n', '<leader>vc', '<cmd>:VenvSelectCached<cr>', {})

require('mini.ai').setup({})
require('mini.pairs').setup({})
require('mini.jump').setup({
  silent = true
})

require('mini.basics').setup({
  options = {
    basic = true,
    extra_ui = true,
    win_borders = 'default',
  },
  mappings = {
    basic = true,
    option_toggle_prefix = [[\]],
    windows = true,
    move_with_alt = true,
  },
  autocommands = {
    basic = true,
    relnum_in_visual_mode = true,
  },
  silent = false,
})


local project_nvim = require("project_nvim")
local recent_projects = project_nvim.get_recent_projects()
local starter = require('mini.starter')
starter.setup({
  items = {
    starter.sections.recent_files(5, false, false),
    {
      { action = 'Telescope file_browser', name = 'Browser',   section = 'Telescope' },
      { action = 'Telescope find_files',   name = 'Files',     section = 'Telescope' },
      { action = 'Telescope live_grep',    name = 'Live grep', section = 'Telescope' },
      { action = 'Telescope projects',     name = 'Projects',  section = 'Telescope' },
    },
    starter.sections.builtin_actions(),
  },
})
require('mini.tabline').setup()
require('mini.statusline').setup({
  set_vim_settings = false
})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('lspconfig').pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        flake8 = { enabled = true },
        autopep8 = { enabled = false },
        jedi_completion = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pydocstyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        rope_completion = { enabled = false },
        yapf = { enabled = false },
      }
    }
  }
})

require('mason').setup({})

require('nvim-treesitter.configs').setup({
  ensure_installed = { "python" },
  highlight = {
    enable = true,
    disable = { '' }
  }
})

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")


require('telescope').setup({
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
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
    file_browser = {
      grouped = true,
      previewer = false,
      respect_gitignore = true,
      sorting_strategy = "ascending",
      hijack_netrw = true,
    },
  }
})

require("telescope").load_extension("file_browser")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fB', ":Telescope file_browser<CR>", {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fp', ":Telescope projects<CR>", {})


require('project_nvim').setup({
  manual_mode = true,
})
require('telescope').load_extension('projects')
require('mini.trailspace').setup({})
require('mini.bracketed').setup({})
require('mini.base16').setup({
  palette = {
    base00 = '#161616',
    base01 = '#262626',
    base02 = '#393939',
    base03 = '#525252',
    base04 = '#dde1e6',
    base05 = '#f2f4f8',
    base06 = '#ffffff',
    base07 = '#08bdba',
    base08 = '#3ddbd9',
    base09 = '#78a9ff',
    base0A = '#ee5396',
    base0B = '#33b1ff',
    base0C = '#ff7eb6',
    base0D = '#42be65',
    base0E = '#be95ff',
    base0F = '#82cfff',
  }
})


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
