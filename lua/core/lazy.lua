-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

lazy.setup({
  spec = {
--  ╭──────────────────────────────────────────────────────────╮
--  │                           lsp                            │
--  ╰──────────────────────────────────────────────────────────╯
  -- LSP
  {'neovim/nvim-lspconfig'},

  -- Autocomplete
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
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
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  },

  -- show surrounding def & block
  -- https://github.com/SmiteshP/nvim-navic
  {
    "SmiteshP/nvim-navic",
    dependencies = {"neovim/nvim-lspconfig"},
  },
--  ╭──────────────────────────────────────────────────────────╮
--  │                        UI                                │
--  ╰──────────────────────────────────────────────────────────╯
  -- Icons, fork of vim-devicons
  -- https://github.com/kyazdani42/nvim-web-devicons
  {'kyazdani42/nvim-web-devicons', lazy = true},


  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
      end
  },

  {
    'mrjones2014/legendary.nvim',
    config = function()
      require('legendary').setup()
    end
  },

  {'skywind3000/vim-quickui'},

  -- buffer management
  -- https://github.com/akinsho/bufferline.nvim
  -- see :h bufferline-usage
  {
    'akinsho/bufferline.nvim',
    tag = "v2.*", dependencies = {'kyazdani42/nvim-web-devicons'},
    opts = {
        options = {
            -- pin tab
            middle_mouse_command = ':BufferLineTogglePin'
        }
    }
  },

  -- replace input and select UI
  -- https://github.com/stevearc/dressing.nvim
  {'stevearc/dressing.nvim'},

  -- Tag viewer
  -- use ctags in sys
  -- https://github.com/preservim/tagbar
  {'preservim/tagbar'},

  -- UndoTree
  {'mbbill/undotree'},

  -- Statusline
  -- https://github.com/feline-nvim/feline.nvim
  {
    'feline-nvim/feline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },

  -- git labels
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = 'require("gitsigns").setup()',
  },

  -- Dashboard (start screen)
  -- https://github.com/goolord/alpha-nvim
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },

  -- scroll bar w/ diagnostic
  -- https://github.com/petertriho/nvim-scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup{}
    end
  },

  -- manage window by only one key
  -- https://gitlab.com/yorickpeterse/nvim-window.git
  {"https://gitlab.com/yorickpeterse/nvim-window.git"},

  -- each active window is golden ratio
  -- https://github.com/dm1try/golden_size
  {'dm1try/golden_size'},

  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup()
    end
  },

  -- zen mode
  -- https://github.com/junegunn/goyo.vim
  {"junegunn/goyo.vim"},

--  ╭──────────────────────────────────────────────────────────╮
--  │                        prettifier                        │
--  ╰──────────────────────────────────────────────────────────╯
  -- show Indent line
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {'lukas-reineke/indent-blankline.nvim'},

  -- https://github.com/LudoPinelli/comment-box.nvim
  {"LudoPinelli/comment-box.nvim"},

  -- Rainbow pairs
  -- https://github.com/p00f/nvim-ts-rainbow
  {'p00f/nvim-ts-rainbow'},

  -- highlight all occurences of selection
  {'RRethy/vim-illuminate'},

  -- highlight todos
  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
    require("todo-comments").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
    end
  },

  -- fold color
  -- https://github.com/kevinhwang91/nvim-ufo
  {
    'kevinhwang91/nvim-ufo',
     dependencies = {'kevinhwang91/promise-async'},
  },


  -- trim empty lines on save
  -- https://github.com/cappyzawa/trim.nvim
  {
    'cappyzawa/trim.nvim',
    opts = {
        fn_blocklist = {'markdown'},
        patterns = {
          [[%s/\s\+$//e]],           -- remove unwanted spaces
          [[%s/\($\n\s*\)\+\%$//]],  -- trim last line
          [[%s/\%^\n\+//]],          -- trim first line
          -- [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
        }
    }
  },

--  ╭──────────────────────────────────────────────────────────╮
--  │                       colorschema                        │
--  ╰──────────────────────────────────────────────────────────╯
  {'navarasu/onedark.nvim'},
  {'tanvirtin/monokai.nvim'},
  { 'rose-pine/neovim', name = 'rose-pine' },

--  ╭──────────────────────────────────────────────────────────╮
--  │                          search                          │
--  ╰──────────────────────────────────────────────────────────╯
  -- search integrate with fzf and fd
  -- https://github.com/nvim-telescope/telescope.nvim#pickers
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    dependencies = {'nvim-lua/plenary.nvim'}
  },

  -- https://github.com/axieax/urlview.nvim
  {
    "axieax/urlview.nvim",
    config = 'require("urlview").setup()',
  },

--  ╭──────────────────────────────────────────────────────────╮
--  │                          motion                          │
--  ╰──────────────────────────────────────────────────────────╯
  -- smooth scrolling
  -- https://github.com/karb94/neoscroll.nvim
  {
    'karb94/neoscroll.nvim',
    opts = {
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
    }
  },

  -- easy motion
  -- https://github.com/phaazon/hop.nvim
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    opts = {
        keys = 'etovxqpdygfblzhckisuran',
        quit_key = '<ESC>',
        jump_on_sole_occurrence = true, -- if only hint a single item, jump directly
        case_insensitive = true
    }
  },

  -- better search highligh UI
  -- https://github.com/kevinhwang91/nvim-hlslens
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()
    end
  },

--  ╭──────────────────────────────────────────────────────────╮
--  │                          filetype                        │
--  ╰──────────────────────────────────────────────────────────╯
  {
    'lervag/vimtex',
  },

  -- https://github.com/preservim/vim-markdown
  {
    'preservim/vim-markdown',
    dependencies = {'godlygeek/tabular'}
  },

  -- live preview of markdown
  {
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
  },

--  ╭──────────────────────────────────────────────────────────╮
--  │                          fm                              │
--  ╰──────────────────────────────────────────────────────────╯

  -- File explorer
  -- https://github.com/kevinhwang91/rnvimr
  {
    'kevinhwang91/rnvimr',
    config = function()
      vim.g.rnvimr_enable_ex = true
      vim.g.rnvimr_enable_picker = true
    end
  },

  -- https://github.com/kyazdani42/nvim-tree.lua
  {'kyazdani42/nvim-tree.lua'},

--  ╭──────────────────────────────────────────────────────────╮
--  │                          edit                            │
--  ╰──────────────────────────────────────────────────────────╯
  -- split lines, opposite of J
  -- https://github.com/AckslD/nvim-trevJ.lua
  {
    'AckslD/nvim-trevJ.lua',
    config = 'require("trevj").setup()',  -- optional call for configurating non-default filetypes etc
    -- lazy load
    lazy = true,
  },

  -- https://github.com/max397574/better-escape.nvim
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = {"jk"},
        timeout = 1000
      })
    end,
  },

  -- https://github.com/numToStr/Comment.nvim
  {
    'numToStr/Comment.nvim',
    config = 'require("Comment").setup()',
  },

  -- Autopair
  {
    'windwp/nvim-autopairs',
    opts = {
        disable_filetype = { "TelescopePrompt" }
    }
  },

  -- textobjs
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {'nvim-treesitter/nvim-treesitter-textobjects'},

  {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

  -- snippet engine
  -- https://github.com/SirVer/ultisnips
  {
    'SirVer/ultisnips',
    dependencies = {
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
  },


--  ╭──────────────────────────────────────────────────────────╮
--  │                          utils                           │
--  ╰──────────────────────────────────────────────────────────╯
  -- use sudo
  -- https://github.com/lambdalisue/suda.vim
  {
    'lambdalisue/suda.vim',
    config = function()
      vim.g.suda_smart_edit = true
      vim.api.nvim_set_keymap('c', 'w!!', ":w suda://%<CR>", { silent = true })
    end
  },

  {'tjdevries/train.nvim'},

  -- if fcitx chinese mode, when leave insert mode switch back to English
  -- https://github.com/h-hg/fcitx.nvim
  {'h-hg/fcitx.nvim'},
  }
})
