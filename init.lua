--  ┏╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┓
--  ╏                     Neovim init file                     ╏
--  ╏                        Fork from:                        ╏
--  ╏   Website: https://github.com/brainfucksec/neovim-lua    ╏
--  ┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛

-- Import Lua modules
if vim.g.vscode then
  print("vscode")
  vim.opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
else
  require('core/lazy')
  require('core/autocmds')
  require('core/keymaps')
  require('core/colors')
  require('core/statusline')
  require('core/options')
  require('plugins/nvim-tree')
  require('plugins/indent-blankline')
  require('plugins/nvim-cmp')
  require('plugins/nvim-lspconfig')
  require('plugins/nvim-treesitter')
  require('plugins/alpha-nvim')
  require('plugins/dressing')
  require('plugins/nvim-navic')
  require('plugins/quickui')
  require('plugins/vimtex')
  require('plugins/vim_markdown')
end
