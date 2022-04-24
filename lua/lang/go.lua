vim.g.go_fmt_command = 'goimports'
vim.g.go_autodetect_gopath = 1
vim.g.go_doc_popup_window = 1
--vim.g.go_bin_path = '$GOBIN'
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1

--禁止在保存的时候提示
vim.g.go_fmt_fail_silently = 1

vim.g.go_highlight_array_whitespace_error = 1
vim.g.go_highlight_chan_whitespace_error = 1
vim.g.go_highlight_space_tab_error = 1
vim.g.go_highlight_trailing_whitespace_error = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_function_parameters = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_string_spellcheck = 1
vim.g.go_highlight_variable_declarations = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_highlight_variable_assignments = 1
--vim.g.go_highlight_diagnostic_warnings = 1

--回车映射，防止补全提示重复
vim.cmd('au FileType go nmap <leader>r <Plug>(go-run)')
vim.cmd('au FileType go nmap <leader>b <Plug>(go-build)')
vim.cmd('au FileType go nmap <leader>t <Plug>(go-test)')
vim.cmd('au FileType go nmap <leader>c <Plug>(go-coverage)')
vim.cmd('au FileType go nmap <leader>i :GoImports<CR>')
vim.cmd('au FileType go nmap <leader>ts :GoTests<CR>')
vim.cmd('au FileType go nmap <leader>tf :GoTestFunc<CR>')
vim.cmd('au FileType go set completeopt-=preview')

-- vim.cmd('au FileType go nmap <space>ds :GoDebugStart<CR>')
-- vim.cmd('au FileType go nmap <space>dt :GoDebugStop<CR>')
-- vim.cmd('au FileType go nmap <space>db :GoDebugBreakpoint<CR>')
-- vim.cmd('au FileType go nmap <space>dc :GoDebugContinue<CR>')
-- vim.cmd('au FileType go nmap <space>dn :GoDebugNext<CR>')
-- GoDebugPrint {$variable} 需要输入变量, 所有不用快捷键
-- vim.cmd('au FileType go nmap <space>dp :GoDebugPrint<CR>')

--[[
-- coc
vim.g.coc_disable_startup_warning = 1
vim.g.coc_global_extensions = {
	'coc-go',
	'coc-snippets'
}
--]]
-- 关闭coc diagnostic
--im.cmd[[let b:coc_diagnostic_disable=1]]
--vim.cmd[[let b:coc_diagnostic_info={'information': 0, 'hint': 0, 'lnums': [0, 0, 0, 0], 'warning': 0, 'error': 0}]]
-- 回车选中补全
--vim.cmd[[inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]]

--[[
-- ale-setting
vim.g.ale_disable_lsp = 1
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


-- 浮窗
function show_documentation()
	local filetype = vim.bo.filetype

	if filetype == 'vim'  or filetype == 'help' then
		vim.api.nvim_command('h ' .. filetype)
	else
		vim.fn.CocActionAsync('doHover')
	end
end
vim.api.nvim_set_keymap( 'n', 'K', ':lua show_documentation()<CR>', { noremap = false, silent = false })
vim.cmd("autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')")
--]]
