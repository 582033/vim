" env init {{{
    scriptencoding utf-8
    set encoding=utf-8
" }}}
" Functions {{{
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
    "autocmd bufnewfile *.md call InserMdHeader()
    "
    "python文件自动增加Header
    function! InserPyHeader()
        call setline(1, '#!/usr/bin/env python')
        call append(1, '# -*- coding: utf-8 -*-')
        call append(2, '')
    endfunction
    autocmd bufnewfile *.py call InserPyHeader()
    "
    "php文件自动增加Header
    function! PhpHeader()
        call setline(1, '<?php')
        call append(1, '')
    endfunction
    autocmd bufnewfile *.php call PhpHeader() 
    "
    "shell自动增加Header
    function! ShellHeader()
        call setline(1, '#!/usr/bin/env bash')
        call append(1, '')
    endfunction
    autocmd bufnewfile *.sh call ShellHeader() 
    "
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
" }}}
" Quick sudoer{{{
    ca w!! w !sudo tee "%"
"}}}
" Formatting {{{

    "set nowrap                      " Do not wrap long lines
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
" TagList{{{
    "let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
    "let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
    "let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口 
    "map <C-t> :TlistToggle<CR>
"}}}
" TagBar{{{
    let g:tagbar_width=20
    nmap <C-t> :TagbarToggle<CR>
"}}}
" Vim UI {{{
    "vim-colors-solarized{{{
    "syntax enable
    set background=dark
    let g:solarized_termtrans=1
    "let g:solarized_contrast="normal"
    "let g:solarized_visibility="normal"
    let g:solarized_termcolors=256
    colorscheme solarized
    set t_Co=256
    "}}}

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
    if has("patch-7.4.710")
        set listchars=tab:\¦\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace ¦, ┆ or │
    else
        set listchars=tab:>\ ,trail:\·,extends:#,nbsp:.
    endif

    "tab缩进
    filetype plugin indent on
    set ts=4 sw=4 et
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
"}}}
" 支持文件关闭回退 {{{
    let $VIMTEMP = $HOME.'/.vim/.vim_tmp/'
    if v:version >= 703
        set undofile
        set undodir=$VIMTEMP
        set undolevels=1000
        set undoreload=10000
    endif
" }}}
" Php Setting {{{
    autocmd filetype php set fdm=syntax
    "设置行内容过长自动折行
    autocmd filetype php set wrap
    "设置文件内容过长语法高亮失效关闭(默认>3000行时高亮失效) -- 已发现问题出在PIV插件
    "autocmd filetype php set synmaxcol=0
    "autocmd filetype php set syntax=php
    " PIV {
    autocmd filetype php let g:DisableAutoPHPFolding = 0
    autocmd filetype php let g:PIVAutoClose = 0
    " }
" }}}
" Python Setting{{{
    filetype plugin indent on
    autocmd filetype python set completeopt+=longest
    autocmd filetype python set completeopt+=menu
    autocmd filetype python set wildmenu
    autocmd filetype python set foldmethod=indent
    "set foldlevel=99
    autocmd filetype python let g:pymode_indent = 0
"}}}
" Html Setting{{{
    filetype plugin indent on
    autocmd filetype html set ts=4 noet
"}}}
" Markdown Setting{{{
    autocmd filetype md set ts=4 noet
"}}}
" 支持gbk文件直接打开{{{
    set fencs=utf-8,gbk
"}}}
"语法检查{{{
    let g:syntastic_check_on_open = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_loc_list_height = 5
    let g:syntastic_enable_highlighting = 0
    let g:syntastic_mode_map = { 'passive_filetypes': ['scss', 'slim', 'html'] }
"}}}
"vimrc折叠{{{
    autocmd FileType vim set fdm=marker
"}}}
"私有配置请写入vim_local{{{
if !empty(glob("~/.vim/vim_local"))
   source ~/.vim/vim_local
   autocmd BufNewFile,BufRead vim_local set filetype=vim
endif
"}}}
"bash_local语法高亮{{{
   autocmd BufNewFile,BufRead .bash_local,bash_local set filetype=sh
"}}}
