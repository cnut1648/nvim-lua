# nvim-lua
My dot file for nvim, `init.vim.bak` is my old vimscript config; starting to use `init.lua` on Sep 10 2022

Check startup time with
```bash
nvim --startuptime startup.log -c exit && tail -100 startup.log
```

## Useful keybinds

For def of keybinds, see [keymap.lua](lua/core/keymaps.lua).

### 1. LSP

- `<C-]>` to jump to def, also ctrl + left click

  double backticks to jump back

### 2. LuaSnip

### 3. Plugins

- `gJ` to smart split a line, reverse of `J`

- powerful search by [hlslens](https://github.com/kevinhwang91/nvim-hlslens), use `??` or `//` to clear highlights

- `s*` for quick hop

- `<leader>f*` for searching with [telescope](https://github.com/nvim-telescope/telescope.nvim#pickers)

- `<leader>t*` for bar, eg `tt` for tagbar

- use `ys<obj><obj2>` to surround `obj` with `obj2`; `ds<obj>` to remove `<obj>`; and `cs<obj><obj2>` to change surrounding `obj` to `obj2`. See [here](https://github.com/kylechui/nvim-surround#rocket-usage) for more

- can always use `which-keys` to show commands; and `quickui` for more

## Useful commands

- `:Urlview` to search for urls in currrent buffer

- `:CB*box` to draw box by [Comment Box](https://github.com/LudoPinelli/comment-box.nvim)

- `:w!!` overwrite permission protected files w/ sudo, powered by `suda.vim`

- `:Train*` from [train](https://github.com/tjdevries/train.nvim) can be used to familiarize textobjects etc


## Tex

Ensure `texlab` is installed for LSP

Snippets are
