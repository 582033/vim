" Vundle{{{
    set nocompatible              " be iMproved
    filetype off                  " required!

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gmarik/vundle'
    " My bundles {{{
        Bundle 'vim-scripts/matchit.zip'
        Bundle 'vim-scripts/taglist.vim'
        Bundle 'vim-scripts/JavaScript-Indent'
        Bundle 'scrooloose/nerdtree'
        Bundle 'plasticboy/vim-markdown'
        Bundle 'tpope/vim-haml'
        Bundle 'kchmck/vim-coffee-script'
        Bundle 'mattn/emmet-vim'
        Bundle 'groenewege/vim-less'
        Bundle 'kien/ctrlp.vim'
        Bundle 'altercation/vim-colors-solarized'
        Bundle 'nathanaelkane/vim-indent-guides'
        "syntax checking plugin
        Bundle 'scrooloose/syntastic'

        "php SDK
        Bundle 'spf13/PIV'
        "Bundle 'Valloric/YouCompleteMe'
        Bundle 'Shougo/neocomplcache.vim'

    " }}}

" }}}
" Functions {{{
    " Function ChangeFoldMethod() {{{
    " Function for changing folding method.
    "
    if version >= 600
        function! ChangeFoldMethod() abort
            let choice = confirm("Which folde method?", "&manual\n&indent\n&expr\nma&rker\n&syntax", 2)
            if choice == 1
                set foldmethod=manual
            elseif choice == 2
                set foldmethod=indent
            elseif choice == 3
                set foldmethod=expr
            elseif choice == 4
                set foldmethod=marker
            elseif choice == 5
                set foldmethod=syntax
            else
            endif
        endfunction
    endif
    " ChangeFoldMethod() }}}
    "
    " Initialize NERDTree as needed {{{
        function! NERDTreeInitAsNeeded()
            redir => bufoutput
            buffers!
            redir END
            let idx = stridx(bufoutput, "NERD_tree")
            if idx > -1
                NERDTreeMirror
                NERDTreeFind
                wincmd l
            endif
        endfunction
    " }}}

    " Strip whitespace {{{}}
        function! StripTrailingWhitespace()
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunction
    " }}}

    " Function FoldLongLines() {{{
    "
    if version >= 600
        function! FoldLongLines() range abort
            let savelnum = line(".")
            let lnum = a:firstline
            let lend = a:lastline
            if lnum == lend
                " No visual area choosen --> whole file
                let lnum = line(".")
                let lend = line("$")
                " Go to the begin of the file
                exec "1go"
            endif
            while lnum <= lend
                " Skip closed folds
                if foldclosed(lnum) != -1
                    let lnum = foldclosedend(lnum) + 1
                    continue
                endif
                let dlzka = strlen(getline("."))
                if dlzka >= g:fold_long_lines
                    " Create fold for one line
                    exec "normal zfl"
                endif
                let lnum = line(".")
                " Move one line down
                exec "normal j"
                if lnum == lend
                    break
                endif
            endwhile
            " ...and go back
            exec "normal " . savelnum . "G"
            redraw!
        endfunction
    endif
    " FoldLongLines() }}}

    " Function AutoLastMod() {{{
    " Provides atomatic change of date in files, if it is set via
    " modeline variable autolastmod to appropriate value.
    "
    function! AutoLastMod()
        if exists("g:autolastmod")
            if g:autolastmod < 1
                return 0;
            elseif g:autolastmod == 1
                call LastMod(g:autolastmodtext)
            endif
        endif
    endfunction
    " AutoLastMod() }}}

    " Function LastMod() {{{
    " Automatic change date in *.html files.
    "
    function! LastMod(text, ...)
        mark d
        let line = "\\1" . strftime("%Y %b %d %X") " text of changed line
        let find = "g/" . a:text           " regexpr to find line
        let matx = a:text . ".*"            " ...if line was found
        exec find
        let curr_line = getline(".")
        if match(curr_line, matx) == 0
            " call setline(line("."), line)
            call setline(line("."), substitute(getline("."), matx, line, ""))
            exec "'d"
        endif
    endfunction
    " LastMod() }}}

    " Function OpenAllWin() {{{
    " Opens windows for all files in the command line.
    " Variable "opened" is used for testing, if window for file was already opened
    " or not. This is prevention for repeat window opening after ViM config file
    " reload.
    "
    function! OpenAllWin()
        " save Vim option to variable
        let s:save_split = &splitbelow
        set splitbelow

        let s:i = 1
        if g:open_all_win == 1
            while s:i < argc()
                if bufwinnr(argv(s:i)) == -1	" buffer doesn't exists or doesn't have window
                    exec ":split " . escape(argv(s:i), ' \')
                    "echo "Current window is " . bufwinnr(s:i) 
                endif
                let s:i = s:i + 1
            endwhile
        endif

        " force first window to be maximalized. Behaviour of vim has changed after
        " 6.2(?) release, therefore next command is not needed for vim < 6.2(?)
        exec "normal 2\<C-w>\<C-w>1\<C-w>\<C-w>"

        " restore Vim option from variable
        if s:save_split
            set splitbelow
        else
            set nosplitbelow
        endif
    endfunction
    " OpenAllWin() }}}
    "
    "markdown文件自动增加样式
    function! InserMdHeader()      
        let l1 = getline(1)      
        if  match('\<l', l1) == 0         
            exec 1        
            normal O       
            call setline(1,'<link rel="stylesheet" href="markdown.css">')    
        endif  
    endfunction    
    autocmd bufnewfile *.md call InserMdHeader() 
    "
    "python文件自动增加Header
    function! InserPyHeader()      
        call setline(1, '#!/user/bin/python')    
        call append(1, '#-*-coding:utf8-*-')    
        call append(2, '')    
    endfunction    
    autocmd bufnewfile *.py call InserPyHeader() 
    "
    "shell自动增加Header
    function! ShellHeader()      
        call setline(1, '#!/bin/sh')
        call append(1, '')    
    endfunction    
    autocmd bufnewfile *.sh call ShellHeader() 
    "
    " Function CallProg() {{{
    function! CallProg() abort
        let choice = confirm("Call:", "&make\nm&ake in cwd\n" .
                    \ "&compile\nc&ompile in cwd\n" .
                    \ "&run\nr&un in cwd")
        if choice == 1
            exec ":wall"
            exec "! cd %:p:h; pwd; make " . g:makeflags
        elseif choice == 2
            exec ":wall"
            exec "! cd " .
                        \ getcwd() . "; pwd; make " . g:makeflags
        elseif choice == 3
            :call Compile(1)
        elseif choice == 4
            :call Compile(0)
        elseif choice == 5
            exec "! cd %:p:h; pwd; ./%:t:r"
        elseif choice == 6
            exec "! cd " . getcwd() . "; pwd; ./%<"
        endif
    endfunction
    " CallProg() }}}

    " Function Compile() {{{
    function! Compile(do_chdir) abort
        let cmd = ""
        let filename = ""
        let filename_ext = ""

        if a:do_chdir == 1
            let cmd = "! cd %:p:h; pwd; "
            let filename = "%:t:r"
            let filename_ext = "%:t"
        else
            let cmd = "! cd " . getcwd() . "; pwd; "
            let filename = "%<"
            let filename_ext = "%"
        endif

        let choice = confirm("Call:", 
                    \ "&compile\n" .
                    \ "compile and &debug\n" .
                    \ "compile and &run\n" .
                    \ "compile using first &line")

        if choice != 0
            exec ":wall"
        endif

        if choice == 1
            exec cmd . "gcc " . g:cflags . 
                        \ " -o " . filename . " " . filename_ext
        elseif choice == 2
            exec cmd . "gcc " . g:cflags . " " . g:c_debug_flags . 
                        \ " -o " . filename . " " . filename_ext " && gdb " . filename
        elseif choice == 3
            exec cmd . "gcc " . g:cflags . 
                        \ " -o " . filename . " " . filename_ext " && ./" . filename
        elseif choice == 4
            exec cmd . "gcc " . g:cflags . 
                        \ " -o " . filename . " " . filename_ext . 
                        \ substitute(substitute(getline(2), "VIMGCC", "", "g"), "GCC", "", "g" )
        endif
    endfunction
    " Compile() }}}

    " Function Indent() {{{
    " Indents source code.
    function! Indent() range abort
        let savelnum = line(".")
        let lnum = a:firstline
        let lend = a:lastline
        if lnum == lend
            " No visual area choosen --> whole file
            let lnum = line(".")
            let lend = line("$")
            " Go to the begin of the file
            exec "1go"
        endif
        exec "normal " . lnum . "Gv" . lend . "G="
        exec "normal " . savelnum . "G"
    endfunction
    " Indent() }}}

    " Function UnquoteMailBody() {{{
    "
    function! UnquoteMailBody() range abort
        " Every backslash character must be escaped in function -- Nepto
        "exec "normal :%s/^\\([ ]*>[ ]*\\)*\\(\\|[^>].*\\)$/\\2/g<CR>"
        let savelnum = line(".")
        let lnum = a:firstline
        let lend = a:lastline
        if lnum == lend
            " No visual area choosen --> whole file
            let lnum = line(".")
            let lend = line("$")
            " Go to the begin of the file
            exec "1go"
        endif
        exec ":" . lnum . "," . lend . "s/^[ >]\\+//"
        exec "normal " . savelnum . "G"
    endfunction
    " UnquoteMailBody() }}}

    " Function SafeLineDelete() {{{
    "
    function! SafeLineDelete()
        exec "normal \"_dd"
    endfunction
    " SafeLineDelete() }}}

    " Function GetID() {{{
    " - used in statusline.
    " If you are root, function return "# " string --> it is showed at begin of
    "                                                  statusline
    " If you aren't root, function return empty string --> nothing is visible
    " Check for your name ID
    let g:get_id = $USER
    " If you are root, set to '#', else set to ''
    if g:get_id == "root"
        let g:get_id = "# "
    else
        let g:get_id = ""
    endif
    function! GetID()
        return g:get_id
    endfunction
    " GetID() }}}

    " Function ReadFileAboveCursor() {{{
    "
    function! ReadFileAboveCursor(file, ...)
        let str = ":" . (v:lnum - 1) . "read " . a:file
        let idx = 1
        while idx <= a:0
            exec "let str = str . \" \" . a:" . idx
            let idx = idx + 1
        endwhile
        exec str
    endfunction
    " ReadFileAboveCursor() }}}

    " Function RemoveAutogroup() {{{
    "
    silent! function! RemoveAutogroup(group)
    silent exec "augroup! ". a:group
    endfunction
    " RemoveAutogroup() }}}

    " Function SmartBS() {{{
    "
    " This function comes from Benji Fisher <benji AT e-mathDOTAMSDOTorg>
    " http://vim.sourceforge.net/scripts/download.php?src_id=409
    " (modified/patched by: Lubomir Host 'rajo' <rajo AT platon.sk>
    "                       Srinath Avadhanula  <srinath AT fastmailDOTfm> )
    silent function! SmartBS()
        let init = strpart(getline("."), 0, col(".")-1)
        if exists("g:smartBS_" . &filetype)
            silent exec "let matchtxt = matchstr(init, g:smartBS_" . &filetype . ")"
            echo "SmartBS(" . matchtxt . ")"
            if matchtxt != ''
                let bstxt = substitute(matchtxt, '.', "\<bs>", 'g')
                return bstxt
            else
                return "\<bs>"
            endif
        else
            return "\<bs>"
        endif
    endfunction

    " You can turn on smart backspacing in ftplugin by setting
    " g:smartBS_<filetype> variable and turning on mapping
    " inoremap <buffer> <BS> <C-R>=SmartBS()<CR>
    "
    " Example: TeX plugin
    "	" set regular expresion for Smart backspacing
    "	let g:smartBS_tex = '\(' .
    "			\ "\\\\[\"^'=v]{\\S}"      . '\|' .
    "			\ "\\\\[\"^'=]\\S"         . '\|' .
    " 			\ '\\v \S'                 . '\|' .
    "			\ "\\\\[\"^'=v]{\\\\[iI]}" . '\|' .
    "			\ '\\v \\[iI]'             . '\|' .
    "			\ '\\q \S'                 . '\|' .
    " 			\ '\\-'                    .
    "			\ '\)' . "$"
    "
    "	" map <BS> to function SmartBS()
    "	inoremap <buffer> <BS> <C-R>=SmartBS()<CR>

    " }}} 

    " Function ChooseInputMethod() {{{
    function! ChooseInputMethod(method)
        let b:disable_imap=0
        let g:available_methods = "&none\n&Tex-universal\n&tex-iso8859-2\n&iso8859-2\n&windows-1250\nunicode-&Html\n&UTF-8"

        if a:method == 0
            let choice = confirm("Choose input mapping:", g:available_methods, 1)
        else
            let choice = a:method
        endif

        if choice == 1
            let b:input_method = "NONE"
        elseif choice == 2
            let b:input_method = "tex-universal"
        elseif choice == 3
            let b:input_method = "tex-iso8859-2"
        elseif choice == 4
            let b:input_method = "iso8859-2"
        elseif choice == 5
            let b:input_method = "windows-1250"
        elseif choice == 6
            let b:input_method = "unicode-html"
        elseif choice == 7
            let b:input_method = "UTF-8"
        endif
        
        if choice == 1
            let b:disable_imap = 1
        elseif choice != 0
            call UseDiacritics()
        endif

    endfunction
    "}}}

    " Function UseDiacritics() {{{
        function! UseDiacritics()
            let b:disable_imap = 0
            call Source("~/.vim/modules/diacritics.vim")
        endfunction
    " }}}

" }}}
" Autocomands {{{
    if has("autocmd")

        " Autocomands for PlatonCopyright {{{
        augroup PlatonCopyright
        autocmd!
        autocmd BufLeave * set titlestring=
        autocmd BufLeave * silent! call RemoveAutogroup("PlatonCopyright")
        autocmd WinEnter * set titlestring=
        autocmd WinEnter * silent! call RemoveAutogroup("PlatonCopyright")
        autocmd BufWrite * set titlestring=
        autocmd BufWrite * silent! call RemoveAutogroup("PlatonCopyright")
        autocmd CmdwinEnter * set titlestring=
        autocmd CmdwinEnter * silent! call RemoveAutogroup("PlatonCopyright")
        augroup END
        " }}}

        " Autocomands for GUIEnter {{{
        augroup GUIEnter
        autocmd!
        if has("gui_win32")
            autocmd GUIEnter * simalt ~x
        endif
        augroup END
        " }}}

        " Autocomands for ~/.vimrc {{{
        augroup VimConfig
        autocmd!
        " Reread configuration of ViM if file ~/.vimrc is saved
        autocmd BufWritePost ~/.vimrc	so ~/.vimrc | exec "normal zv"
        autocmd BufWritePost vimrc   	so ~/.vimrc | exec "normal zv"
        augroup END
        " }}}

        " Autocommands for *.c, *.h, *.cc *.cpp {{{
        augroup C
        autocmd!
        "formatovanie C-zdrojakov
        autocmd BufEnter     *.c,*.h,*.cc,*.cpp	map  <buffer> <C-F> mfggvG$='f
        autocmd BufEnter     *.c,*.h,*.cc,*.cpp	imap <buffer> <C-F> <Esc>mfggvG$='fi
        autocmd BufEnter     *.c,*.h,*.cc,*.cpp	map <buffer> yii yyp3wdwi
        autocmd BufEnter     *.c,*.h,*.cc,*.cpp	map <buffer> <C-K> :call CallProg()<CR>
        autocmd BufRead,BufNewFile  *.c,*.h,*.cc,*.cpp	setlocal cindent
        autocmd BufRead,BufNewFile  *.c,*.h,*.cc,*.cpp	setlocal cinoptions=>4,e0,n0,f0,{0,}0,^0,:4,=4,p4,t4,c3,+4,(2s,u1s,)20,*30,g4,h4
        autocmd BufRead,BufNewFile  *.c,*.h,*.cc,*.cpp	setlocal cinkeys=0{,0},:,0#,!<C-F>,o,O,e
        augroup END
        " }}}

        " Autocommands for *.html *.cgi {{{
        " Automatic updates date of last modification in HTML files. File must
        " contain line "^\([<space><Tab>]*\)Last modified: ",
        " else will be date writtend on the current " line.
        augroup HtmlCgiPHP
        autocmd!
        " Appending right part of tag in HTML files.
        autocmd BufEnter                 *.phtml	imap <buffer> QQ </><Esc>2F<lywf>f/pF<i
        autocmd BufWritePre,FileWritePre *.phtml	call AutoLastMod()
        autocmd BufEnter                 *.html	imap <buffer> QQ </><Esc>2F<lywf>f/pF<i
        autocmd BufWritePre,FileWritePre *.html	call AutoLastMod()
        autocmd BufEnter                 *.cgi	imap <buffer> QQ </><Esc>2F<lywf>f/pF<i
        autocmd BufWritePre,FileWritePre *.cgi	call AutoLastMod()
        autocmd BufEnter                 *.php	imap <buffer> QQ </><Esc>2F<lywf>f/pF<i
        autocmd BufWritePre,FileWritePre *.php	call AutoLastMod()
        autocmd BufEnter                 *.php3	imap <buffer> QQ </><Esc>2F<lywf>f/pF<i
        autocmd BufWritePre,FileWritePre *.php3	call AutoLastMod()
        augroup END
        " }}}

        " Autocomands for *.tcl {{{
        augroup Tcl
        autocmd!
        autocmd WinEnter            *.tcl	map <buffer> <C-K> :call CallProg()<CR>
        autocmd BufRead,BufNewFile  *.tcl	setlocal autoindent
        augroup END
        " }}}

        " Autocomands for *.tpl {{{
        autocmd BufRead,BufNewFile  *.tpl	setlocal autoindent
        " }}}

        " Autocomands for *.txt {{{
        augroup Txt
        autocmd BufNewFile,BufRead  *.txt   setf txt
        augroup END
        " }}}

        " Autocomands for *.tt2 {{{
        augroup Tt2
        autocmd BufNewFile,BufRead  *.tt2   setf tt2
        augroup END
        " }}}
        " *.hs {{{
        augroup hs
        autocmd Bufenter *.hs compiler ghc
        augroup END
        " }}}

        " Autocomands for Makefile {{{
        augroup Makefile
        autocmd!
        autocmd BufEnter            [Mm]akefile*	map <buffer> <C-K> :call CallProg()<CR>
        augroup END
        " }}}

        " Autocomands for GnuPG (gpg) {{{ 
        " Transparent editing of gpg encrypted files.
        " By Wouter Hanegraaff <wouter@blub.net>,
        " enhanced by Lubomir Host 'rajo' <rajo AT platon.sk>
        " 
        augroup GnuPG
            autocmd!

            " First make sure nothing is written to ~/.viminfo while editing
            " an encrypted file.
            " viminfo doesn't have local value, set global value instead
            autocmd BufReadPre,FileReadPre		*.gpg,*.asc set viminfo=
            " We don't want a swap file, as it writes unencrypted data to disk
            autocmd BufReadPre,FileReadPre		*.gpg,*.asc setlocal noswapfile
            " Switch to binary mode to read the encrypted file
            autocmd BufReadPre,FileReadPre		*.gpg,*.asc setlocal bin
            autocmd BufReadPre,FileReadPre		*.gpg,*.asc let ch_save = &ch | setlocal ch=2
            autocmd BufReadPost,FileReadPost	*.gpg,*.asc '[,']!gpg --decrypt -q -a 2>/dev/null
            " Switch to normal mode for editing
            autocmd BufReadPost,FileReadPost	*.gpg,*.asc setlocal nobin
            autocmd BufReadPost,FileReadPost	*.gpg,*.asc let &ch = ch_save | unlet ch_save
            autocmd BufReadPost,FileReadPost	*.gpg,*.asc execute ":doautocmd BufReadPost " . expand("%:r")

            " Convert all text to encrypted text before writing
            autocmd BufWritePre,FileWritePre	*.gpg,*.asc '[,']!gpg --encrypt --default-recipient-self -q -a
            " Undo the encryption so we are back in the normal text, directly
            " after the file has been written.
            autocmd BufWritePost,FileWritePost	*.gpg,*.asc undo
        augroup END
        " }}}

    endif " if has("autocmd")
" }}} Autocomands
" Quick sudoer{{{
    ca w!! w !sudo tee "%"
"}}}
" Ctrlp 设置{{{
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_working_path_mode = 'ra'
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux 忽略文件
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows 忽略文件
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" }}}
" Formatting {{{

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell setlocal nospell

" }}}}
" NerdTree {{{
    map <c-e> :NERDTreeToggle<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1                                                                      
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
" }}}
" Vim UI {{{
    syntax enable
    set background=dark
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    let g:solarized_termcolors=256
    set t_Co=256
    colorscheme solarized

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    let g:CSApprox_hook_post = ['hi clear SignColumn']
    highlight clear CursorLineNr    " Remove highlight color from current line number

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
" }}}
"{{{ 对齐线
"hi CursorColumn ctermbg=4
    nmap <F11> :set cursorline!<BAR>set nocursorline?<CR>
    nmap <F12> :set cursorcolumn!<BAR>set nocursorcolumn?<CR>
"}}}
"缩进线{{{
    "空格缩进
    set list
    set listchars=tab:\¦\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace ¦, ┆ or │

    "tab缩进
    filetype plugin indent on
    set ts=4 sw=4 et
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
"}}}
" 支持文件关闭回退 {{{
    let $VIMTEMP = $VIMFILES.'/tmp'
    if v:version >= 703
        set undofile
        set undodir=$VIMTEMP
        set undolevels=1000
        set undoreload=10000
    endif
" }}}
" Php Setting {{{
    autocmd filetype php set fdm=marker
    " PIV {
    let g:DisableAutoPHPFolding = 0
    let g:PIVAutoClose = 0
    " }
" }}}
" Python Setting{{{
    filetype plugin indent on
    set completeopt+=longest
    set completeopt+=menu
    set wildmenu
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType vim 	set fdm=marker
"}}}
" 支持gbk文件直接打开{{{
    set fencs=utf-8,gbk
"}}}
" 自动补全neocomplcache{{{
    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    " audo pop
    let g:neocomplcache_enable_auto_select = 1

    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}}}
"语法检查{{{
    let g:syntastic_check_on_open = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_loc_list_height = 5
    let g:syntastic_enable_highlighting = 0
    let g:syntastic_mode_map = { 'passive_filetypes': ['scss', 'slim'] }
"}}}
autocmd FileType vim set fdm=marker
