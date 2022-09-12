vim.cmd([[
" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
call quickui#menu#install('&File', [
            \ [ "&Open File", 'tabe' ],
            \ [ "&Close\t(:bd)", 'Bclose' ],
            \ [ "&Save\t(:w)", 'write'],
            \ [ "--", '' ],
            \ [ "LeaderF &File", 'Leaderf file', 'Open file with leaderf'],
            \ [ "LeaderF &Mru", 'Leaderf mru --regexMode', 'Open recently accessed files'],
            \ [ "LeaderF &Buffer", 'Leaderf buffer', 'List current buffers in leaderf'],
            \ [ "--", '' ],
            \ [ "E&xit\t(:qa)", 'qa' ],
            \ ])

" items containing tips, tips will display in the cmdline
call quickui#menu#install('&Edit', [
            \ ['Copyright &Header', 'call feedkeys("\<esc> ec")', 'Insert copyright information at the beginning'],
            \ ['&Trailing Space', 'call StripTrailingWhitespace()', ''],
            \ ['Update &ModTime', 'call UpdateLastModified()', ''],
            \ ['&Paste Mode Line', 'PasteVimModeLine', ''],
            \ ['Format J&son', '%!python -m json.tool', ''],
            \ ['--'],
            \ ['&Align Table', 'Tabularize /|', ''],
            \ ['Align &Cheatsheet', 'MyCheatSheetAlign', ''],
            \ ])

call quickui#menu#install('&Symbol',[
            \["&GrepWord\t(InProject)",'callMenuHelp_GrepCode()','Grepkeywordincurrentproject'],
            \["--",],
            \["Find&Definition\t(GNUGlobal)",'callMenuHelp_Gscope("g")','GNUGlobalsearchg'],
            \["Find&Symbol\t(GNUGlobal)",'callMenuHelp_Gscope("s")','GNUGloalsearchs'],
            \["Find&Calledby\t(GNUGlobal)",'callMenuHelp_Gscope("d")','GNUGlobalsearchd'],
            \["FindC&alling\t(GNUGlobal)",'callMenuHelp_Gscope("c")','GNUGlobalsearchc'],
            \["Find&FromCtags\t(GNUGlobal)",'callMenuHelp_Gscope("z")','GNUGlobalsearchc'],
            \["--",],
            \["GotoD&efinition\t(YCM)",''],
            \["Goto&References\t(YCM)",''],
            \["GetD&oc\t(YCM)",'',],
            \["Get&Type\t(YCM)",''],
            \])


call quickui#menu#install('&Move', [
            \ ["Quickfix &First\t:cfirst", 'cfirst', 'quickfix cursor rewind'],
            \ ["Quickfix L&ast\t:clast", 'clast', 'quickfix cursor to the end'],
            \ ["Quickfix &Next\t:cnext", 'cnext', 'cursor next'],
            \ ["Quickfix &Previous\t:cprev", 'cprev', 'quickfix cursor previous'],
            \ ])

call quickui#menu#install("&Build", [
            \ ["File &Execute\tF5", 'AsyncTask file-run'],
            \ ["File &Compile\tF9", 'AsyncTask file-build'],
            \ ["File E&make\tF7", 'AsyncTask emake'],
            \ ["File &Start\tF8", 'AsyncTask emake-exe'],
            \ ['--', ''],
            \ ["&Project Build\tShift+F9", 'AsyncTask project-build'],
            \ ["Project &Run\tShift+F5", 'AsyncTask project-run'],
            \ ["Project &Test\tShift+F6", 'AsyncTask project-test'],
            \ ["Project &Init\tShift+F7", 'AsyncTask project-init'],
            \ ['--', ''],
            \ ['E&dit Task', 'AsyncTask -e'],
            \ ['Edit &Global Task', 'AsyncTask -E'],
            \ ['&Stop Building', 'AsyncStop'],
            \ ])

call quickui#menu#install("&Git", [
            \ ['&View Diff', 'call svnhelp#svn_diff("%")'],
            \ ['&Show Log', 'call svnhelp#svn_log("%")'],
            \ ['File &Add', 'call svnhelp#svn_add("%")'],
            \ ])

call quickui#menu#install('&Tools', [
            \ ['Compare &History', 'call svnhelp#compare_ask_file()', ''],
            \ ['&Compare Buffer', 'call svnhelp#compare_ask_buffer()', ''],
            \ ['--',''],
            \ ['List &Buffer', 'call quickui#tools#list_buffer("FileSwitch tabe")', ],
            \ ['List &Function', 'call quickui#tools#list_function()', ],
            \ ['Display &Messages', 'call quickui#tools#display_messages()', ],
            \ ['--',''],
            \ ["&DelimitMate %{get(b:, 'delimitMate_enabled', 0)? 'Disable':'Enable'}", 'DelimitMateSwitch'],
            \ ['Read &URL', 'call menu#ReadUrl()', 'load content from url into current buffer'],
            \ ['&Spell %{&spell? "Disable":"Enable"}', 'set spell!', 'Toggle spell check %{&spell? "off" : "on"}'],
            \ ['&Profile Start', 'call MonitorInit()', ''],
            \ ['Profile S&top', 'call MonitorExit()', ''],
            \ ["Relati&ve number %{&relativenumber? 'OFF':'ON'}", 'set relativenumber!'],
            \ ["Proxy &Enable", 'call MenuHelp_Proxy(1)', 'setup http_proxy/https_proxy/all_proxy'],
            \ ["Proxy D&isable", 'call MenuHelp_Proxy(0)', 'clear http_proxy/https_proxy/all_proxy'],
            \ ])

call quickui#menu#install('&Plugin', [
            \ ["&Ranger\t<leader>k", 'Ranger', 'toggle Ranger'],
            \ ["&CoC-explorer\t<leader>e", 'CocCommand explorer', 'toggle explorer'],
            \ ["-"],
            \ ["&Browse in github\trhubarb", "Gbrowse", "using tpope's rhubarb to open browse and view the file"],
            \ ["&Startify", "Startify", "using tpope's rhubarb to open browse and view the file"],
            \ ["&Gist", "Gist", "open gist with mattn/gist-vim"],
            \ ["&Edit Note", "Note", "edit note with vim-notes"],
            \ ["&Display Calendar", "Calendar", "display a calender"],
            \ ["Toggle &Floaterm\t(F10)", 'FloatermToggle', 'floatting term'],
            \ ["Toggle &Vista\t(F8)", 'Vista!!', 'explore tags'],
            \ ["Toggle &Mundo Tree\t(F4)", 'MundoToggle', 'undo tree'],
            \ ["-"],
            \ ["Plugin &List", "PlugStatus", "Update list"],
            \ ["Plugin &Update", "PlugUpdate", "Update plugin"],
            \ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
            \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
            \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
            \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
            \ ["-"],
            \ ['Set &GUI %{&termguicolors? "Off":"On"}', 'set termguicolors!'],
            \ ])


" register HELP menu with weight 10000
call quickui#menu#install('Help (&?)', [
            \ ["&Index", 'tab help index', ''],
            \ ['Ti&ps', 'tab help tips', ''],
            \ ['--',''],
            \ ["&Tutorial", 'tab help tutor', ''],
            \ ['&Quick Reference', 'tab help quickref', ''],
            \ ['&Summary', 'tab help summary', ''],
            \ ['--',''],
            \ ['&Vim Script', 'tab help eval', ''],
            \ ['&Function List', 'tab help function-list', ''],
            \ ['&Dash Help', 'call asclib#utils#dash_ft(&ft, expand("<cword>"))'],
            \ ], 10000)


let g:context_menu_k = [
            \ ["&Peek Definition\tAlt+;", 'call quickui#tools#preview_tag("")'],
            \ ["S&earch in Project\t\\cx", 'exec "silent! GrepCode! " . expand("<cword>")'],
            \ [ "--", ],
            \ [ "Find &Definition\t\\cg", 'call MenuHelp_Fscope("g")', 'GNU Global search g'],
            \ [ "Find &Symbol\t\\cs", 'call MenuHelp_Fscope("s")', 'GNU Gloal search s'],
            \ [ "Find &Called by\t\\cd", 'call MenuHelp_Fscope("d")', 'GNU Global search d'],
            \ [ "Find C&alling\t\\cc", 'call MenuHelp_Fscope("c")', 'GNU Global search c'],
            \ [ "Find &From Ctags\t\\cz", 'call MenuHelp_Fscope("z")', 'GNU Global search c'],
            \ [ "--", ],
            \ [ "Goto D&efinition\t(YCM)", 'YcmCompleter GoToDefinitionElseDeclaration'],
            \ [ "Goto &References\t(YCM)", 'YcmCompleter GoToReferences'],
            \ [ "Get D&oc\t(YCM)", 'YcmCompleter GetDoc'],
            \ [ "Get &Type\t(YCM)", 'YcmCompleter GetTypeImprecise'],
            \ [ "--", ],
            \ ['Dash &Help', 'call asclib#utils#dash_ft(&ft, expand("<cword>"))'],
            \ ['Cpp&man', 'exec "Cppman " . expand("<cword>")', '', 'c,cpp'],
            \ ]

call quickui#menu#install('&Writing', [
            \ [ "&Focus\t(F5)", 'Goyo', 'use goyo & limelight' ],
            \ [ '&Preview', 'MarkdownPreview' ],
            \ [ "--", ],
            \ ['&Next Wordy', 'NextWordy'],
            \ ['No &Wordy', 'NoWordy'],
            \ [ "--", ],
            \ ['&Ditto', 'Ditto'],
            \ ], '<auto>', 'text,md,markdown')


" enable to display tips in the cmdline
let g:quickui_show_tip = 1

" hit space twice to open menu
noremap <silent> <space><space> :call quickui#menu#open()<cr>

nnoremap <silent>K :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
]])
