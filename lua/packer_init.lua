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

  -- quicker loading
  -- https://github.com/lewis6991/impatient.nvim
  use 'lewis6991/impatient.nvim'

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

  -- show surrounding def & block
  -- https://github.com/SmiteshP/nvim-navic
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                        UI                                │
--  ╰──────────────────────────────────────────────────────────╯
  -- Icons, fork of vim-devicons
  -- https://github.com/kyazdani42/nvim-web-devicons
  use 'kyazdani42/nvim-web-devicons'

  -- https://github.com/folke/which-key.nvim
  use {
    "folke/which-key.nvim",
    module = 'which-key',
    config = function()
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
      end
  }

  use 'skywind3000/vim-quickui'

  -- buffer management
  -- https://github.com/akinsho/bufferline.nvim
  -- see :h bufferline-usage
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup{
        options = {
            -- pin tab
            middle_mouse_command = ':BufferLineTogglePin'
        }
      }
    end
  }

  -- replace input and select UI
  -- https://github.com/stevearc/dressing.nvim
  use 'stevearc/dressing.nvim'

  -- Tag viewer
  -- use ctags in sys
  -- https://github.com/preservim/tagbar
  use 'preservim/tagbar'

  -- Statusline
  -- https://github.com/feline-nvim/feline.nvim
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
  -- https://github.com/goolord/alpha-nvim
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- scroll bar w/ diagnostic
  -- https://github.com/petertriho/nvim-scrollbar
  use {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup{}
    end
  }

  -- manage window
  -- https://gitlab.com/yorickpeterse/nvim-window.git
  use "https://gitlab.com/yorickpeterse/nvim-window.git"

  -- each active window is golden ratio
  -- https://github.com/dm1try/golden_size
  use 'dm1try/golden_size'

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup()
    end
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                        prettifier                        │
--  ╰──────────────────────────────────────────────────────────╯
  -- show Indent line
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  use 'lukas-reineke/indent-blankline.nvim'

  -- https://github.com/LudoPinelli/comment-box.nvim
  use "LudoPinelli/comment-box.nvim"

  -- Rainbow pairs
  -- https://github.com/p00f/nvim-ts-rainbow
  use 'p00f/nvim-ts-rainbow'

  -- highlight all occurences of selection
  use 'RRethy/vim-illuminate'

  -- trim empty lines
  -- https://github.com/cappyzawa/trim.nvim
  use {
    'cappyzawa/trim.nvim',
    config = function()
      require('trim').setup({
        disable = {'markdown'},
        patterns = {
          [[%s/\s\+$//e]],           -- remove unwanted spaces
          [[%s/\($\n\s*\)\+\%$//]],  -- trim last line
          [[%s/\%^\n\+//]],          -- trim first line
          -- [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
        }
      })
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
  -- search integrate with fzf and fd
  -- https://github.com/nvim-telescope/telescope.nvim#pickers
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- https://github.com/axieax/urlview.nvim
  use "axieax/urlview.nvim"

--  ╭──────────────────────────────────────────────────────────╮
--  │                          motion                          │
--  ╰──────────────────────────────────────────────────────────╯
  -- smooth scrolling
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

  -- easy motion
  -- https://github.com/phaazon/hop.nvim
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup {
        keys = 'etovxqpdygfblzhckisuran',
        quit_key = '<ESC>',
        jump_on_sole_occurrence = true, -- if only hint a single item, jump directly
        case_insensitive = true
      }
    end
  }

  -- better search highligh UI
  -- https://github.com/kevinhwang91/nvim-hlslens
  use {'kevinhwang91/nvim-hlslens'}

--  ╭──────────────────────────────────────────────────────────╮
--  │                          fm                              │
--  ╰──────────────────────────────────────────────────────────╯

  -- File explorer
  -- https://github.com/kevinhwang91/rnvimr
  use {
    'kevinhwang91/rnvimr',
    config = function()
      vim.g.rnvimr_enable_ex = true
      vim.g.rnvimr_enable_picker = true
    end
  }
  -- https://github.com/kyazdani42/nvim-tree.lua
  use 'kyazdani42/nvim-tree.lua'

--  ╭──────────────────────────────────────────────────────────╮
--  │                          filetype                        │
--  ╰──────────────────────────────────────────────────────────╯
  use {
    'lervag/vimtex',
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                          edit                            │
--  ╰──────────────────────────────────────────────────────────╯
  -- split lines, opposite of J
  -- https://github.com/AckslD/nvim-trevJ.lua
  use {
    'AckslD/nvim-trevJ.lua',
    config = 'require("trevj").setup()',  -- optional call for configurating non-default filetypes etc
    -- lazy load
    module = 'trevj',
  }

  -- https://github.com/numToStr/Comment.nvim
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
      require('nvim-autopairs').setup{
        disable_filetype = { "TelescopePrompt" }
      }
    end
  }

--  ╭──────────────────────────────────────────────────────────╮
--  │                          utils                           │
--  ╰──────────────────────────────────────────────────────────╯
  -- use sudo
  -- https://github.com/lambdalisue/suda.vim
  use {
    'lambdalisue/suda.vim',
    config = function()
      vim.g.suda_smart_edit = true
      vim.api.nvim_set_keymap('c', 'w!!', ":w suda://%<CR>", { silent = true })
    end
  }

  use 'tjdevries/train.nvim'

  use 'L3MON4D3/LuaSnip'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
