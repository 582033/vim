require("trouble").setup {
	-- icon used for open folds
	fold_open = "v",
	-- icon used for closed folds
	fold_closed = ">",
	-- add an indent guide below the fold icons
	indent_lines = false,
	signs = {
		-- icons / text used for a diagnostic
		error = "✗",
		warning = "⚠",
		hint = "hint",
		information = "info"
	},
	-- enabling this will use the signs defined in your lsp client
	use_lsp_diagnostic_signs = false
}
