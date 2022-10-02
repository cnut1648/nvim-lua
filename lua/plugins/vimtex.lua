vim.cmd([[
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
" let g:vimtex_view_method = 'zathura'
let g:vimtex_view_method = 'sioyek'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

  " \ '_'                : '-lualatex',
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
  \}

let g:vimtex_fold_enabled = 1
let g:vimtex_format_enabled = 1

" make latexmk save auxiliary files (also pdf) to build/
let g:vimtex_compiler_latexmk = {
  \ 'build_dir' : './build',
  \ 'continuous' : 1,
  \ 'executable' : 'latexmk',
  \ 'hooks' : [],
  \ 'options' : [
  \   '-verbose',
  \   '-file-line-error',
  \   '-synctex=1',
  \   '-interaction=nonstopmode',
  \ ],
\}


let g:vimtex_env_toggle_math_map = {
      \ '$': '\[',
      \ '\[': 'equation',
      \ 'equation': 'align*',
      \ 'align*': 'multline*',
      \ 'multline*': 'gather',
      \}

let g:vimtex_syntax_conceal = {
    \ 'math_bounds': 0,
\}

" Don't open QuickFix for warning messages if no errors are present
let g:vimtex_quickfix_open_on_warning = 0

" Filter out some compilation warning messages from QuickFix display
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull \\hbox',
      \ 'Overfull \\hbox',
      \ 'LaTeX Warning: .\+ float specifier changed to',
      \ 'Package microtype Warning: Unable to apply patch',
      \ 'Package microtype Warning: One or more slots in the configuration',
      \ 'LaTeX hooks Warning',
      \ 'Package siunitx Warning: Detected the "physics" package:',
      \ 'Package hyperref Warning: Token not allowed in a PDF string',
      \ 'LaTex Font Warning: Font shape',
      \]
]])
