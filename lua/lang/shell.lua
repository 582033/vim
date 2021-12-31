--shell文件头设置
function ShellHeader()
	vim.fn.setline(1, '#!/usr/bin/env bash')
	vim.fn.append(1, '')
end
vim.api.nvim_command('autocmd bufnewfile *.sh lua ShellHeader()')
