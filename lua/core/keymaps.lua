-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--  default config dir
CONFIG_DIR = os.getenv("HOME") .. "/.config/nvim/"

-- Change leader to a space
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-----------------------------------------------------------
-----------------------------------------------------------
--                           _
--                          (_)
--  _ __   ___  _____   ___ _ __ ___
-- | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
-- | | | |  __/ (_) \ V /| | | | | | |
-- |_| |_|\___|\___/ \_/ |_|_| |_| |_|
-----------------------------------------------------------
-----------------------------------------------------------

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

----------------------------------------------
-- tab management
----------------------------------------------
map('n', '<C-p>', ':tabnew<CR>') -- new tab
map('n', '<C-h>', ':tabprevious<CR>') -- last tab
map('n', '<C-l>', ':tabnext<CR>') -- next tab

----------------------------------------------
-- buffer/file management
----------------------------------------------
map('n', '<C-j>', ':bprevious<CR>') -- last file
map('n', '<C-k>', ':bnext<CR>') -- next file

----------------------------------------------
-- window management
-- M-S  => alt+shift
----------------------------------------------
map('n', '<M-S-v>', '<C-W><C-S>') -- vertical split
map('n', '<M-S-g>', '<C-W><C-V>') -- horizontal split
map('n', '<M-S-n>', '<C-W>T') -- move this window to new tab
map('n', '<M-S-m>', '<C-W>n') -- create new window
-- navigate
map('n', '<M-S-h>', '<C-W>h')
map('n', '<M-S-j>', '<C-W>j')
map('n', '<M-S-k>', '<C-W>k')
map('n', '<M-S-l>', '<C-W>l')
map('n', '<M-S-p>', '<C-W>p') -- previous window
map('n', '<M-S-w>', '<C-W>w') -- move down
map('n', '<M-S-b>', '<C-W>b') -- move to bottom
map('n', '<M-S-q>', '<C-W>q') -- quit current window
map('n', '<M-S-a>', '<C-W>o') -- make current window the only window, others are closed
-- change size
map('n', '<M-S-->', '<C-W>-')
map('n', '<M-S-+>', '<C-W>+')
map('n', '<M-S-<>', '<C-W><')
map('n', '<M-S->>', '<C-W>>')
map('n', '<M-S-=>', ":lua require('nvim-window').pick()<CR>") -- select window by one key

-- Map Esc to jk
map('i', 'jk', '<Esc>')
-- going back to normal mode which works even in vim's terminal
-- you will need this if you use floaterm to escape terminal
map('t', '<Esc>', '<c-\\><c-n>')

-- Clear search highlighting
map('n', '//', ':nohl<CR>')
map('n', '??', ':nohl<CR>')

-- Toggle auto-indenting for code paste
map('n', '<F2>', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = '<F2>'

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Empty line inject
map('n', 'oo', 'o')
map('n', 'OO', 'O')
map('n', 'o', 'o<Esc>k')
map('n', 'O', 'O<Esc>j')

-- Write & Reload configuration
-- always <leader>x
map('n', '<leader>xv', ':e ' .. CONFIG_DIR  .. 'init.lua<CR>')
-- refresh snip
map('n', '<leader>xs', ': UltiSnips#RefreshSnippets()<CR>')
map('n', '<leader>xr', ':w <bar> :so ' .. CONFIG_DIR .. 'init.lua<CR>')
map('n', '<leader>xo', ':set rnu! <CR>')


-- Reload configuration without restart nvim

-- Fast saving with <leader> and s
-- map('n', '<leader>s', ':w<CR>')
-- map('i', '<leader>s', '<C-c>:w<CR>')

-- Close all windows and exit fromseovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

--[[
    easier moving of code blocks
    Try to go into visual mode (v), thenselect several lines of code
    here and then press ``>`` several times.
--]]
map('v', '<', '<gv')
map('v', '>', '>gv')
-- move selected line(s) up or down
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- auto correct spellchecker by first candidate (1z=)
map('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u')

-----------------------------------------------------------
-----------------------------------------------------------
-- ______ _             _
-- | ___ \ |           (_)
-- | |_/ / |_   _  __ _ _ _ __
-- |  __/| | | | |/ _` | | '_ \
-- | |   | | |_| | (_| | | | | |
-- \_|   |_|\__,_|\__, |_|_| |_|
--                 __/ |
--                |___/
-----------------------------------------------------------
-----------------------------------------------------------

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- Tagbar
map('n', '<leader>tt', ':TagbarToggle<CR>')          -- open/close

-- NvimTree
map('n', '<leader>tn', ':NvimTreeToggle<CR>')            -- open/close
-- map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
-- map('n', '<leader>tn', ':NvimTreeFindFile<CR>')      -- search file

-- Ranger
map('n', '<leader>k', ':RnvimrToggle<CR>')

-- Comment https://github.com/numToStr/Comment.nvim
-- IDE like comment
map('n', '<C-/>', ":lua require('Comment.api').toggle.linewise.current()<CR>")

-- Telescope https://github.com/nvim-telescope/telescope.nvim
-- in pwd
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
-- string in pwd
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
-- search file name in buffer
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>ft', '<cmd>Telescope help_tags<cr>')
-- previous search, select then research
map('n', '<leader>fs', '<cmd>Telescope search_history<cr>')
-- recent files
map('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>')

-- Hop https://github.com/phaazon/hop.nvim
-- disable s
map('', 's', '<NOP>')
map('', 'S', '<NOP>')
-- did not override f/F/t/T due to dot repeat, eg df can't be repeated anymore
-- lowercase forward; uppercase backward
map('', 'sf', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>")
map('', 'sF', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>")
map('', 'st', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>")
map('', 'sT', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>")
-- lowercase for this buffer
-- uppercase for whole visible buffer
map('', 'sw', "<cmd>:HopWord<CR>")
map('', 'SW', "<cmd>:HopWordMW<CR>")
map('', 'sb', "<cmd>:HopChar2<CR>")
map('', 'SB', "<cmd>:HopChar2MW<CR>")
map('', 'sp', "<cmd>:HopPattern<CR>")
map('', 'SP', "<cmd>:HopPatternMW<CR>")
map('', 'su', "<cmd>:HopVertical<CR>")
map('', 'SU', "<cmd>:HopVerticalMW<CR>")
map('', 'sl', "<cmd>:HopLineStart<CR>")
map('', 'SL', "<cmd>:HopLineStartMW<CR>")

-- hlslens https://github.com/kevinhwang91/nvim-hlslens
map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

-- trevJ https://github.com/AckslD/nvim-trevJ.lua
map('n', 'gJ', "<cmd>lua require('trevj').format_at_cursor()<cr>")

-- vimtext https://github.com/lervag/vimtex
-- single shot complie + save current buffer
map('n', '<leader>lc', '<Cmd>update<CR><Cmd>VimtexCompileSS<CR>')

-- LSP
map('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<cr>')

-- snip
vim.cmd[[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]

-- inkscape figure
-- https://github.com/gillescastel/inkscape-figures
-- .! means direct script output to current line
vim.cmd [[
autocmd FileType tex inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
autocmd FileType tex nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
autocmd FileType tex inoremap <C-s> <Esc>: silent exec '.!python ~/.config/nvim/save_screenshot.py "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>
]]

-- todo comments, https://github.com/folke/todo-comments.nvim
-- jump between TODOS
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Undotree, https://github.com/mbbill/undotree
map('n', '<leader>tu', ':UndotreeToggle<CR>')          -- open/close
