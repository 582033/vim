vim.g.syntastic_error_symbol = '✗'
--设置警告符号
vim.g.syntastic_warning_symbol = '⚠'
--是否在打开文件时检查
vim.g.syntastic_check_on_open = 1
--是否在保存文件后检查
--vim.g.syntastic_check_on_wq=1
vim.g.syntastic_auto_loc_list = 1
vim.g.syntastic_loc_list_height = 5
vim.g.syntastic_enable_highlighting = 0
--被动检查的文件类型
vim.g.syntastic_mode_map = "{ 'passive_filetypes': ['html'] }"
