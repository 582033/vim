local function PythonHeader()
	--python文件头设置
	vim.fn.setline(1, '#!/usr/bin/env python')
	vim.fn.append(1, '# -*- coding: utf-8 -*-')
	vim.fn.append(2, '')
	--样式设置
	--vim.o.foldlevel = 99
	vim.cmd('completeopt+=longest')
	vim.cmd('set completeopt+=menu')
	vim.o.wildmenu = true
	vim.o.foldmethod = 'indent'
	vim.g.pymode_indent = 0
end 
vim.cmd('autocmd bufnewfile *.py call PythonHeader()')
