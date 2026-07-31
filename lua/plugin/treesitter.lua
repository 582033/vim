local ensure_installed = { "go", "html", "php", "yaml", "markdown", "markdown_inline", "bash", "json", "javascript", "python", "typescript", "lua", "vim" }

require('nvim-treesitter').install(ensure_installed)

-- 启用高亮
vim.api.nvim_create_autocmd('FileType', {
	pattern = ensure_installed,
	callback = function()
		vim.treesitter.start()
	end,
})

-- 启用缩进
vim.api.nvim_create_autocmd('FileType', {
	pattern = ensure_installed,
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
