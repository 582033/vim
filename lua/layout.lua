--主题
vim.g.synaxt = 'enable'
vim.api.nvim_set_option('background', 'dark')
--if packer_plugins['vim-solarized8'] and packer_plugins['vim-solarized8'].loaded then
	vim.g.solarized_termtrans = 1
	vim.g.solarized_termcolors = 256
	vim.g.colorscheme = 'solarized8'
--end

--Vim UI
vim.g.t_Co = 256
--Only show 15 tabs
vim.g.tabpagemax = 15
--显示当前模式 - 插入/可视等
vim.g.showmode = true
--突出显示当前行
vim.g.cursorline = true
--显示行号
vim.g.nu = true
--显示括号匹配
vim.g.showmatch = true
--开启实时搜索
vim.g.incsearch = true
--开启高亮
vim.g.hlsearch = true
vim.cmd('highlight clear SignColumn')
vim.cmd('highlight clear LineNr')
vim.g.CSApprox_hook_post = "['hi clear SignColumn']"
vim.cmd('highlight clear CursorLineNr')

vim.g.backspace = 'indent,eol,start'
vim.g.linespace = 0             
vim.g.winminheight = 0          
vim.g.ignorecase = true
vim.g.smartcase = true
vim.g.wildmenu = true
vim.g.wildmode = 'list:longest,full'
vim.g.whichwrap = 'b,s,h,l,<,>,[,]'
vim.g.scrolljump = 5
vim.g.scrolloff = 3
vim.g.foldenable = true

--对齐线
--vim.cmd('highlight CursorColumn ctermbg=4')
vim.api.nvim_set_keymap('n', '<F11>', ':set cursorline!<BAR>set nocursorline?<CR>', {})
vim.api.nvim_set_keymap('n', '<F12>', ':set cursorcolumn!<BAR>set nocursorcolumn?<CR>', {})
