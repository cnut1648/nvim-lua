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
map('n', '<M-S-n>', '<C-W>T') -- move to new window
map('n', '<M-S-m>', '<C-W>n') -- create new window
-- navigate
map('n', '<M-S-h>', '<C-W>h')
map('n', '<M-S-j>', '<C-W>j')
map('n', '<M-S-k>', '<C-W>k')
map('n', '<M-S-l>', '<C-W>l')
map('n', '<M-S-p>', '<C-W>p')
map('n', '<M-S-w>', '<C-W>w')
map('n', '<M-S-b>', '<C-W>b')
map('n', '<M-S-q>', '<C-W>q')
map('n', '<M-S-a>', '<C-W>o')
-- change size
map('n', '<M-S-->', '<C-W>-')
map('n', '<M-S-+>', '<C-W>+')
map('n', '<M-S-<>', '<C-W><')
map('n', '<M-S->>', '<C-W>>')

-- Map Esc to jk
map('i', 'jk', '<Esc>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

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
map('n', '<leader>xv', ':e ' .. CONFIG_DIR  .. 'init.lua<CR>')
map('n', '<leader>xr', ':w <bar> :so ' .. CONFIG_DIR .. 'init.lua<CR>')

-- Reload configuration without restart nvim

-- Fast saving with <leader> and s
-- map('n', '<leader>s', ':w<CR>')
-- map('i', '<leader>s', '<C-c>:w<CR>')

-- Close all windows and exit fromseovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

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

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- Tagbar
map('n', '<leader>z', ':TagbarToggle<CR>')          -- open/close

-- Ranger
map('n', '<leader>k', ':RnvimrToggle<CR>')
