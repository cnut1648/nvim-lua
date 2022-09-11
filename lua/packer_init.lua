-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Add you plugins here:

  -- https://github.com/wbthomason/packer.nvim
  use 'wbthomason/packer.nvim' -- packer can manage itself

--  ╭──────────────────────────────────────────────────────────╮
--  │                           lsp                            │
--  ╰──────────────────────────────────────────────────────────╯
  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                        UI                                │
--  ╰──────────────────────────────────────────────────────────╯
  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  use {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })
    end
  }

  -- Tag viewer
  -- use ctags in sys
  use 'preservim/tagbar'

  -- Statusline
  use {
    'feline-nvim/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup{}
    end
  }

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                        prettifier                        │
--  ╰──────────────────────────────────────────────────────────╯
  -- show Indent line
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  use 'lukas-reineke/indent-blankline.nvim'

  -- https://github.com/LudoPinelli/comment-box.nvim
  use "LudoPinelli/comment-box.nvim"

  -- Treesitter interface
  use 'p00f/nvim-ts-rainbow'

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                       colorschema                        │
--  ╰──────────────────────────────────────────────────────────╯
  use 'navarasu/onedark.nvim'
  use 'tanvirtin/monokai.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }

--  ╭──────────────────────────────────────────────────────────╮
--  │                          search                          │
--  ╰──────────────────────────────────────────────────────────╯
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                          motion                          │
--  ╰──────────────────────────────────────────────────────────╯
  -- https://github.com/karb94/neoscroll.nvim
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                    '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = false,    -- Disable "Performance Mode" on all buffers.
        easing_function = "quadratic" -- quadratic accleration
      })
    end
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                          fm                              │
--  ╰──────────────────────────────────────────────────────────╯

  -- File explorer
  use {
    'kevinhwang91/rnvimr',
    config = function()
      vim.g.rnvimr_enable_ex = true
      vim.g.rnvimr_enable_picker = true
    end
  }
  use 'kyazdani42/nvim-tree.lua'



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
