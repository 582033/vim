require'nvim-treesitter.configs'.setup{
	ensure_installed = { "go", "html", "php", "yaml", "markdown", "bash", "json", "javascript", "bash", "python", "typescript", "vim"},
	-- 启用高亮
	highlight = {
		enable = true,
		-- 禁用 vim 基于正则达式的语法高亮，太慢
		additional_vim_regex_highlighting = false
	}
}
