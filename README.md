# nvim-lua
My dot file for nvim, `init.vim.bak` is my old vimscript config; starting to use `init.lua` on Sep 10 2022.

Check startup time with
```bash
nvim --startuptime startup.log -c exit && tail -100 startup.log
```

## Install

Make sure `neovim-git` is installed via `yay`. Then

## Useful keybinds

For def of keybinds, see [keymap.lua](lua/core/keymaps.lua).

### 1. LSP

- `<C-]>` to jump to def, also ctrl + left click

  double backticks to jump back

- `:LspInfo` to test filetype LSP support

### 2. Plugins

- `[s/]s` jump to spell checker detected error; `zg` add current word to dictionary; `z=` select candidates; `1z=` select first candidate

- `gJ` to smart split a line, reverse of `J`

- powerful search by [hlslens](https://github.com/kevinhwang91/nvim-hlslens), use `??` or `//` to clear highlights

- `s*` for quick hop

- `<leader>f*` for searching with [telescope](https://github.com/nvim-telescope/telescope.nvim#pickers)

- `<leader>t*` for bar, eg `tt` for tagbar

- use `ys<obj><obj2>` to surround `obj` with `obj2`; `ds<obj>` to remove `<obj>`; and `cs<obj><obj2>` to change surrounding `obj` to `obj2`. See [here](https://github.com/kylechui/nvim-surround#rocket-usage) for more

- can always use `which-keys` to show commands; and `quickui` for more

- `:bd` to delete current buffer; while `:q` quit whole neovim (all buffers)

## Useful commands

- `:Urlview` to search for urls in currrent buffer

- `:CB*box` to draw box by [Comment Box](https://github.com/LudoPinelli/comment-box.nvim)

- `:w!!` overwrite permission protected files w/ sudo, powered by `suda.vim`

- `:Train*` from [train](https://github.com/tjdevries/train.nvim) can be used to familiarize textobjects etc

- `<C-t>` open terminal


## Tex

Ensure `texlab` is installed for LSP

To enable vimtex on markdown, symlink `snip/tex.snippets`

New text objects are `c` (commands eg `\textbf`); `d` (delimiters eg `( x + y)`, also `\big(\big)`); `e` (environment eg `align`); `$` (inline math mode); `P` (sections); `m` (items in `enumerate` or `itemize`)

Commands include

- `<F7>` insert new command, eg in visual mode after selection; `<F6>` insert new environment

- in insert mode `]]` complete current environment

- `<c/d>s<obj>`, smart (eg `csd[` on `\left(\right)` => `\left[\right]`)

- `ts<c/e>` toggle command or env, eg `\section` => `\section*` or `\begin{equation}` => `\begin{equation*}`

- `ts$` toggle between math inline to math display and equation

- `tsd` toggle plain vs `\left/\right` versions of delimiters

- `tsf` toggle fraction

- `%` move within env, inline math, delimiters

- `]]` and `[[` jump around `section`, `subsection`, `subsubsection`

- `]m` and `[m` jump between env

- `]n` and `[n` jump between math (inline or display)

- `:VimtexDocPackage` on `\usepackage{}` to see doc

- You can jump to the TeX source code of packages, style files, and documents included with \include{} and \input{} using the gf shortcut; you can read more about this feature at :help vimtex-includeexpr ?????

- `:VimtexCount*` count letters / words

- In insert mode first type figure filename then `<C-f>` to insert figures by inkscape; `<C-f>` in normal mode to edit figures. More details ref to [Gilles Castel](https://github.com/gillescastel/inkscape-figures). Must run `inks cape-figures watch` first.

- In insert mode first take a screenshot, then type figure name, hit `<C-s>` and it will automatically append screenshot
