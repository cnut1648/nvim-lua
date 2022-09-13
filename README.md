# nvim-lua
My dot file for nvim

`init.vim.bak` is my old vimscript config; starting to use `init.lua` on Sep 10 2022

Check startup time with
```bash
nvim --startuptime startup.log -c exit && tail -100 startup.log
```

## Useful keybinds

### LSP

- `<C-]>` to jump to def, also ctrl + left click

  double backticks to jump back


## Useful commands

- `:Urlview` to search for urls in currrent buffer

- `:CB*box` to draw box by [Comment Box](https://github.com/LudoPinelli/comment-box.nvim)

- `:w!!` overwrite permission protected files w/ sudo, powered by `suda.vim`

- `:Train*` from [train](https://github.com/tjdevries/train.nvim) can be used to familiarize textobjects etc
