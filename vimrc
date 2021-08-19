" env init {{{
    " 定义快捷键的前缀
    let mapleader = ","
    " 设置<leader>n为切换行号显示隐藏
    map <Leader>n :set invnumber<CR>

    scriptencoding utf-8
    set encoding=utf-8
    "不适用vi键盘模式,而使用vim的
    set nocompatible
    "filetype off                  " required!
    "插件缩进
    "filetype plugin indent on
    set pyxversion=2
    " Python3的可执行文件位置
    let g:python3_host_prog = "/usr/local/bin/python3"
" }}}
" Plug{{{
    call plug#begin('~/.vim/plugged')
    Plug 'vim-scripts/matchit.zip'
    "Plug 'vim-scripts/taglist.vim'
    Plug 'majutsushi/tagbar', { 'on':'TagbarToggle' }
    Plug 'vim-scripts/JavaScript-Indent', { 'for':['php', 'html', 'javascript'] }
    Plug 'preservim/nerdtree'
    Plug 'plasticboy/vim-markdown', { 'for':'markdown' }
    Plug 'kien/ctrlp.vim'
    Plug 'altercation/vim-colors-solarized'
    "可视化缩进
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'chr4/nginx.vim'
    "语法检查
    Plug 'scrooloose/syntastic'
    "systemd 系统文件高亮
    Plug 'Matt-Deacalion/vim-systemd-syntax'

    "php
    "Plug 'spf13/PIV', { 'for': 'php' }
    Plug 'StanAngeloff/php.vim', { 'for':'php' }

    "python
    Plug 'hynek/vim-python-pep8-indent', { 'for':'python' }

    "go
    Plug 'fatih/vim-go', { 'do':':GoUpdateBinaries', 'for':'go' }
    "Plug 'fatih/vim-go', { 'tag':'*', 'do':':GoUpdateBinaries', 'for':'go' }
    Plug 'buoto/gotests-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    "代码片段工具
    Plug 'drmingdrmer/xptemplate'
    "括号自动匹配
    "Plug 'jiangmiao/auto-pairs'
    
    "plist文件支持
    Plug 'darfink/vim-plist'

    "启动界面快速打开最近的文件
    Plug 'mhinz/vim-startify'
    call plug#end()
" }}}
" Functions {{{
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
" }}}
" Quick sudoer{{{
    ca w!! w !sudo tee "%"
"}}}
" Ctrlp 设置{{{
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_working_path_mode = 'ra'
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux 忽略文件
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows 忽略文件
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_user_command = 'cd %s && find .'
    let g:ctrlp_use_caching = 0
" }}}
" NerdTree {{{
    map <c-e> :NERDTreeToggle<CR>
    map <leader>f :NERDTreeFind<cr>
" }}}
" Ctags{{{
    set tags=./tags;/,~/.vimtags
"}}}
" TagBar{{{
    let g:tagbar_width=20
    nmap <C-t> :TagbarToggle<CR>
"}}}
"语法检查scrooloose/syntastic{{{
    "设置错误符号
    let g:syntastic_error_symbol = '✗'
    "设置警告符号
    let g:syntastic_warning_symbol = '⚠'
    "是否在打开文件时检查
    let g:syntastic_check_on_open = 1
    "是否在保存文件后检查
    "let g:syntastic_check_on_wq=1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_loc_list_height = 5
    let g:syntastic_enable_highlighting = 0
    "被动检查的文件类型
    let g:syntastic_mode_map = { 'passive_filetypes': ['html'] }
"}}}
" Vim UI {{{
    "vim-colors-solarized{{{
    syntax enable
    set background=dark
    let g:solarized_termtrans=1
    "let g:solarized_contrast="normal"
    "let g:solarized_visibility="normal"
    let g:solarized_termcolors=256
    colorscheme solarized
    set t_Co=256
    "}}}

    set tabpagemax=15               " Only show 15 tabs
    "显示当前模式 - 插入/可视等
    set showmode
    "突出显示当前行
    set cursorline                  " Highlight current line
    "显示行号
    set nu
    "显示括号匹配
    set showmatch
    "开启实时搜索
    set incsearch
    "开启高亮
    set hlsearch

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    let g:CSApprox_hook_post = ['hi clear SignColumn']
    highlight clear CursorLineNr    " Remove highlight color from current line number

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
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
"不可见字符设置{{{
    " Highlight problematic whitespace ¦, ┆ or │
    "set list
    "if has("patch-7.4.710")
    "    set listchars=tab:\¦\ ,trail:•,extends:#,nbsp:.
    "else
    "    set listchars=tab:>\ ,trail:\·,extends:#,nbsp:.
    "endif
"}}}
"缩进线{{{
    set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    "let g:indentLine_char='┆'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    "自定义缩进线颜色
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=darkgray   ctermbg=234
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
    autocmd filetype python set completeopt+=longest
    autocmd filetype python set completeopt+=menu
    autocmd filetype python set wildmenu
    autocmd filetype python set foldmethod=indent
    "set foldlevel=99
    autocmd filetype python let g:pymode_indent = 0
"}}}
" Go Setting{{{
    "let g:go_version_warning = 0
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1

    let g:go_fmt_command = "goimports"

    let g:go_highlight_extra_types = 1
    "回车映射，防止补全提示重复
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    "au filetype go nmap <leader>r :GoRun<CR>
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)
    au FileType go nmap <leader>i :GoImports<CR>
    au FileType go nmap <leader>ts :GoTests<CR>
    au FileType go nmap <leader>tf :GoTestFunc<CR>
    au FileType go set completeopt-=preview
" }}}
" Html && Tpl Setting{{{
    autocmd filetype html set ts=4 noet
    autocmd filetype tpl set ts=4 noet
"}}}
" Markdown Setting{{{
    autocmd filetype md set ts=4 noet
"}}}
" 支持gbk文件直接打开{{{
    set fencs=utf-8,gbk
"}}}
"vimrc折叠{{{
    autocmd FileType vim set fdm=marker
"}}}
"bash_local语法高亮{{{
   autocmd BufNewFile,BufRead .bash_local,bash_local set filetype=sh
"}}}
" 加载详细配置 {{{
"私有配置请写入`conf/local.vimrc
for f in split(glob('~/.vim/conf/*.vimrc'), '\n')
    exe 'source' f
endfor
"}}}
