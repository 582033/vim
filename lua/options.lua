--定义快捷键的前缀
vim.g.mapleader = ','
--设置<leader>n为切换行号显示隐藏
vim.api.nvim_set_keymap('n', '<leader>n', ':set invnumber<cr>', {})

--默认显示行号
vim.api.nvim_set_option('number', true)

-- 支持gbk文件直接打开
vim.g.funcs = 'utf-8,gbk'

--vimrc折叠
vim.api.nvim_command('autocmd BufNewFile,BufRead .bash_local,bash_local set filetype=sh')
--bash_local语法高亮
vim.api.nvim_command('autocmd FileType vim set fdm=marker')


--支持文件关闭回退
if vim.fn.has('persistent_undo') == 1 then
	local vimTemp = '~/.config/.vim_tmp/'
	vim.cmd(string.format("silent !mkdir -p %s > /dev/null 2>&1", vimTemp))
	vim.cmd('set undofile')
	vim.cmd(string.format("set undodir=%s", vimTemp))
	vim.cmd('set undolevels=1000')
	vim.cmd('set undoreload=10000')
end

--Quick sudoer
vim.cmd("ca w!! w !sudo tee '%'")
