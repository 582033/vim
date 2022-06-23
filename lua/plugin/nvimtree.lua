--初始按键绑定:https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
require('nvim-tree').setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
				{ key = "gi", action = "split" },
				--{ key = "r", action = "refresh" },
				--解绑原按键
				{ key = "<C-e>", action = "" },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	}
})
