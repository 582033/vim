vim.g.coc_global_extensions = {
	'coc-go',
	'coc-snippets'
}
vim.g.go_fmt_command = 'goimports'
vim.g.go_autodetect_gopath = 1
--vim.g.go_bin_path = '$GOBIN'
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_generate_tags = 1

--回车映射，防止补全提示重复
vim.cmd('au FileType go nmap <leader>r <Plug>(go-run)')
vim.cmd('au FileType go nmap <leader>b <Plug>(go-build)')
vim.cmd('au FileType go nmap <leader>t <Plug>(go-test)')
vim.cmd('au FileType go nmap <leader>c <Plug>(go-coverage)')
vim.cmd('au FileType go nmap <leader>i :GoImports<CR>')
vim.cmd('au FileType go nmap <leader>ts :GoTests<CR>')
vim.cmd('au FileType go nmap <leader>tf :GoTestFunc<CR>')
vim.cmd('au FileType go set completeopt-=preview')

-- ale-setting
vim.g.ale_set_highlights = 1
vim.g.ale_set_quickfix = 1
-- 自定义error和warning图标
vim.g.ale_sign_error = '✗'
vim.g.ale_sign_warning = '⚠'
-- 在vim自带的状态栏中整合ale
vim.g.ale_statusline_format = {
	'✗ %d',
	'⚠ %d',
	'✔ OK'
}
-- 显示Linter名称,出错或警告等相关信息
vim.g.ale_echo_msg_error_str = 'E'
vim.g.ale_echo_msg_warning_str = 'W'
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
-- 打开文件时不进行检查
vim.g.ale_lint_on_enter = 1

-- 普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
vim.api.nvim_set_keymap('n', 'sp', '<Plug>(ale_previous_wrap)', {})
vim.api.nvim_set_keymap('n', 'sn', '<Plug>(ale_next_wrap)', {})

-- 指定ale调用gopls
vim.g.ale_linters = {
	go = {'gopls'}
}
-- coc
vim.g.coc_disable_startup_warning = 1

-- 浮窗
function show_documentation()
	local filetype = vim.bo.filetype

	if filetype == 'vim'  or filetype == 'help' then
		vim.api.nvim_command('h ' .. filetype)
	else
		vim.fn.CocActionAsync('doHover')
	end
end
vim.api.nvim_set_keymap( 'n', 'K', ':lua show_documentation()<CR>', { noremap = false, silent = false });
vim.cmd("autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')")
