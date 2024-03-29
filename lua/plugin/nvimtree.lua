-- 禁用netrw
vim.api.nvim_set_var('loaded_netrw', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)

--初始按键绑定:https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then return end

-- 高度百分比
local HEIGHT_RATIO = 0.9
--宽度百分比
local WIDTH_RATIO = 0.2

nvimtree.setup {
	on_attach = function(bufnr)
		local api = require "nvim-tree.api"
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		api.config.mappings.default_on_attach(bufnr)
		vim.keymap.set('n', 'u',     api.tree.change_root_to_parent,        opts('Up'))
		vim.keymap.set('n', 'gi',     api.node.open.vertical,        opts('Open: Vertical Split'))
		--vim.keymap.set('n', 'gi',     api.node.open.horizontal,        opts('Open: Horizontal Split'))
		vim.keymap.set('n', 'x',     api.node.navigate.parent_close,        opts('Close Directory'))
		--解绑原按键
		vim.keymap.del('n', '<C-e>', { buffer = bufnr })
	end,
	disable_netrw = true,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true
	},
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
}
