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
    },
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

  -- interact with treesitter -- neovim parser
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate"
  },

--  ╭──────────────────────────────────────────────────────────╮
--  │                     statusline                           │
--  ╰──────────────────────────────────────────────────────────╯
  -- Statusline
  -- fork of original https://github.com/feline-nvim/feline.nvim
  -- https://github.com/freddiehaddad/feline.nvim
  {
    "freddiehaddad/feline.nvim",
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },

  -- show surrounding def & block, used in statusline
  -- https://github.com/SmiteshP/nvim-navic
  {
    "SmiteshP/nvim-navic",
    dependencies = {"neovim/nvim-lspconfig", "freddiehaddad/feline.nvim"},
  },

  -- buffer management
  -- https://github.com/akinsho/bufferline.nvim
  -- see :h bufferline-usage
  {
    'akinsho/bufferline.nvim',
    dependencies = {'kyazdani42/nvim-web-devicons'},
    opts = {
        options = {
            -- pin tab
            middle_mouse_command = ':BufferLineTogglePin'
        }
    }
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

  -- search commands by :Legendary
  -- https://github.com/mrjones2014/legendary.nvim
  {
    'mrjones2014/legendary.nvim',
    config = function()
      require('legendary').setup()
    end
  },

  {'skywind3000/vim-quickui'},

  -- replace input and select UI
  -- https://github.com/stevearc/dressing.nvim
  {'stevearc/dressing.nvim'},

  -- Tag viewer
  -- https://github.com/stevearc/aerial.nvim
  {
    "stevearc/aerial.nvim",
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
      end,
      layout = {
        -- These control the width of the aerial window.
        -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a list of mixed types.
        -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
        -- max_width = { 100, 0.5 },
        max_width = { 0.5 },
        min_width = { 0.2 },
        -- Determines the default direction to open the aerial window. The 'prefer'
        -- options will open the window in the other direction *if* there is a
        -- different buffer in the way of the preferred direction
        -- Enum: prefer_right, prefer_left, right, left, float
        default_direction = "prefer_right",
      },
    },
  },

  -- UndoTree
  {'mbbill/undotree'},

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

  -- each focused window is maximize automatically
  -- https://github.com/anuvyklack/windows.nvim
  { "anuvyklack/windows.nvim",
   dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
   },
   opts = {
     ignore = {
       buftype = { 'quickfix' },
       filetype = {"qf"} -- tex compile error window is not maximized
     }
   },
   config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
   end
  },

  -- render color when see color code in terminal
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup()
    end
  },

  -- config in plugins/nvim-navic.lua
  -- https://github.com/SmiteshP/nvim-navbuddy
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim"
    },
  },

  -- show cursor line and highlight
  -- https://github.com/Tummetott/reticle.nvim/
  {
    'tummetott/reticle.nvim',
    event = 'VeryLazy',
    opts = {
      disable_in_insert = true,
    }
  },

  -- rainbow delimiters
  -- https://github.com/HiPhish/rainbow-delimiters.nvim
  {
    "HiPhish/rainbow-delimiters.nvim"
  },

--  ╭──────────────────────────────────────────────────────────╮
--  │                        prettifier                        │
--  ╰──────────────────────────────────────────────────────────╯
  -- show Indent line
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {}},

  -- https://github.com/LudoPinelli/comment-box.nvim
  {"LudoPinelli/comment-box.nvim"},

  -- highlight all occurences of selection
  {'RRethy/vim-illuminate'},

  -- fold color
  -- https://github.com/kevinhwang91/nvim-ufo
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufRead",
    keys = {
        { "zR", function() require("ufo").openAllFolds() end },
        { "zM", function() require("ufo").closeAllFolds() end },
        { "K", function()
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end }
    },
    opts = function(_, opts)
      -- To show number of folded lines
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ('  %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end
      opts.fold_virt_text_handler = handler
    end
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

  -- colorful window container
  -- https://github.com/nvim-zh/colorful-winsep.nvim
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },

  -- use relative number in normal mode; absolute in insert mode
  -- https://github.com/cpea2506/relative-toggle.nvim
  {"cpea2506/relative-toggle.nvim"},


--  ╭──────────────────────────────────────────────────────────╮
--  │                       colorschema                        │
--  ╰──────────────────────────────────────────────────────────╯
  {'navarasu/onedark.nvim'},
  {'tanvirtin/monokai.nvim'},
  { "catppuccin/nvim", name = "catppuccin" },
  { "rebelot/kanagawa.nvim" },

--  ╭──────────────────────────────────────────────────────────╮
--  │                          search                          │
--  ╰──────────────────────────────────────────────────────────╯
  -- search integrate with fzf and fd
  -- https://github.com/nvim-telescope/telescope.nvim#pickers
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {'nvim-lua/plenary.nvim'}
  },

  -- UrlView to view all urls; UrlView Lazy view all lazy plugin's url
  -- https://github.com/axieax/urlview.nvim
  {
    "axieax/urlview.nvim",
    opts = {
      default_action = "system"
    }
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
  -- https://github.com/folke/flash.nvim
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
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
        textopdfbufferasstdin = true,
        mdtohtmlbufferasstdin = true
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

  -- split and rejoin lines
  -- https://github.com/Wansmer/treesj
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false
    }
  },

  -- escape is jk, but will delay jjjjj
  -- use this plugin to prevent
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

  -- https://github.com/kylechui/nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
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


	-- swap arguments
  -- https://github.com/Wansmer/sibling-swap.nvim
	{
		'Wansmer/sibling-swap.nvim',
		dependencies = { 'nvim-treesitter' },
		keys = {
      {"<C-.>", "<cmd>lua require('sibling-swap').swap_with_right()<cr>", desc="swap with right"},
      {"<C-,>", "<cmd>lua require('sibling-swap').swap_with_left()<cr>", desc="swap with left"},
		},
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

  -- if fcitx chinese mode, when leave insert mode switch back to English
  -- https://github.com/h-hg/fcitx.nvim
  {'h-hg/fcitx.nvim'},

  -- cellular-automaton
  -- :CellularAutomaton make_it_rain
  -- or
  -- :CellularAutomaton game_of_life
  -- https://github.com/Eandrju/cellular-automaton.nvim
  {'eandrju/cellular-automaton.nvim'},
  }
})
