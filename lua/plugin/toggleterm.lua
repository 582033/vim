require("toggleterm").setup{
	open_mapping = [[<leader>tm]],
	size = 80,
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true,
	--persist_size = true,
	close_on_exit = true,
	shell = vim.o.shell,
	--浮动窗口
	direction = 'float',
}
