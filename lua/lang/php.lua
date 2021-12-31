function PhpHeader()
	--文件头设置
	vim.fn.setline(1, '<?php')
	vim.fn.append(1, '')

	--设置文件内容过长语法高亮失效关闭(默认>3000行时高亮失效) -- 已发现问题出在PIV插件
	--vim.o.synmaxcol = 0
	--vim.o.syntax = php
	
	--[[
	vim.o.fmd = 'syntax'
	vim.o.wrap = true

	--PIV
	vim.g.DisableAutoPHPFolding = 0
	vim.g.PIVAutoClose = 0
	--]]
end
vim.api.nvim_command('autocmd bufnewfile *.php lua PhpHeader()')
