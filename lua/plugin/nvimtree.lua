--初始按键绑定:https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then return end

-- 高度百分比
local HEIGHT_RATIO = 1.0
--宽度百分比
local WIDTH_RATIO = 0.2

nvimtree.setup({
	disable_netrw = true,
	sync_root_with_cwd = true,
	sort_by = "case_sensitive",
	view = {
		float = {
			enable = true,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				--local center_x = (screen_w - window_w) / 2
				local center_x = - window_w
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
				{ key = "gi", action = "split" },
				--{ key = "r", action = "refresh" },
				--解绑原按键
				{ key = "<C-e>", action = "" },
				{ key = "x", action = "close_node" },
			},
		},
		width = function()
			return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
		end,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	}
})
