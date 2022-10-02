-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim
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
      'hrsh7th/cmp-nvim-lsp',
      "quangnguyen30192/cmp-nvim-ultisnips",
      config = function()
        -- optional call to setup (see customization section)
        require("cmp_nvim_ultisnips").setup{
          filetype_source = "treesitter",
          show_snippets = "all",
          documentation = function(snippet)
            return snippet.description
          end
        }
      end,
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
    config = function()
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
      end
  }

  use {
    'mrjones2014/legendary.nvim',
    config = function()
      require('legendary').setup()
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

  -- UndoTree
  use 'mbbill/undotree'

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

  -- manage window by only one key
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

  -- zen mode
  -- https://github.com/junegunn/goyo.vim
  use "junegunn/goyo.vim"

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

  -- highlight todos
  -- https://github.com/folke/todo-comments.nvim
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
    require("todo-comments").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
    end
  }

  -- trim empty lines on save
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
        mappings = {'<C-u>', '<C-d>', '<C-b>', -- '<C-f>',
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
--  │                          filetype                        │
--  ╰──────────────────────────────────────────────────────────╯
  use {
    'lervag/vimtex',
  }

  use {
    "frabjous/knap",
    config = function()
      local gknapsettings = {
        htmltohtmlviewerlaunch = "live-server --quiet --browser=google-chrome-stable --open=%outputfile% --watch=%outputfile% --wait=800 /tmp",
        htmltohtmlviewerrefresh = "none",
        mdtohtml="tmpfile=\"/tmp/$(basename %outputfile%)\" ; pandoc --standalone %docroot% -o \"$tmpfile\"",
        mdtohtmlviewerlaunch = "live-server --quiet --browser=google-chrome-stable --open=%outputfile% --watch=%outputfile% --wait=800 /tmp",
        mdtohtmlviewerrefresh = "none",
      }
      vim.g.knap_settings = gknapsettings
    end
  }

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

  -- https://github.com/max397574/better-escape.nvim
  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = {"jk"},
        timeout = 1000
      })
    end,
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

  -- textobjs
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  use {'nvim-treesitter/nvim-treesitter-textobjects'}

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })

  -- snippet engine
  -- https://github.com/SirVer/ultisnips
  use {
    'SirVer/ultisnips',
    requires = {
      -- predef snippets
      'honza/vim-snippets'
    },
    config = function()
      vim.cmd [[
        let g:UltiSnipsSnippetDirectories=["snip"]
        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"
      ]]
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

  -- if fcitx chinese mode, when leave insert mode switch back to English
  -- https://github.com/h-hg/fcitx.nvim
  use 'h-hg/fcitx.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
