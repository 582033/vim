local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(install_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		install_path,
	})
end
vim.opt.rtp:prepend(install_path)

require("lazy").setup({
	-- avante
	{
		"yetone/avante.nvim",		
		event = "VeryLazy",
		lazy = false,
		version = false,
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-tree/nvim-web-devicons", 
			"zbirenbaum/copilot.lua", 
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		config = function ()
			require("avante")
		end
	},
	---- codeium
	--{
	--	'Exafunction/codeium.vim',
	--	dependencies = {
	--		"nvim-lua/plenary.nvim",
	--		"hrsh7th/nvim-cmp",
	--	},
	--	config = function ()
	--		--require("codeium").setup({ })
	--	end
	--},
	--启动界面快速打开最近的文件
	{'mhinz/vim-startify'},
	-- nginx 配置文件高亮
	{
		'chr4/nginx.vim'
	},
	-- php
	--{'spf13/PIV', ft="php"},
	--代码片段工具
	{'hrsh7th/cmp-vsnip'},
	{'hrsh7th/vim-vsnip'},
	{'hrsh7th/vim-vsnip-integ'},
	{
		'kyazdani42/nvim-tree.lua',
		dependencies = {
			'kyazdani42/nvim-web-devicons'
		},
		keys = {
			{ '<c-e>', ':NvimTreeToggle<CR>' },
			{ '<c-d>', ':NvimTreeFindFile<CR>' }
		},
		config = function()
			require('plugin.nvimtree')
		end

	},
	{
		'plasticboy/vim-markdown', 
		ft = 'markdown'
	},
	--主题
	{
		--'lifepillar/vim-solarized8',
		'sainnhe/sonokai',
		dependencies = {
			'rktjmp/lush.nvim'
		},
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd('colorscheme sonokai')
			--vim.cmd('hi Normal ctermfg=white ctermbg=black')
		end
	},
	--状态栏
	{
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
		config = function()
			require('plugin.lualine')
		end
	},
	--python
	{
		'hynek/vim-python-pep8-indent', 
		ft = "python"
	},
	--go
	{
		'ray-x/go.nvim',
		dependencies = {
			'ray-x/guihua.lua',
			'neovim/nvim-lspconfig',
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require('plugin.go')
		end,
		event = {"CmdlineEnter"},
		ft = {"go", 'gomod'},
	},
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-neotest/nvim-nio'
		},
	},
	{'theHamsta/nvim-dap-virtual-text'},
	-- 语法高亮(多语言支持); 语法树链接
	-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
	{
		'nvim-treesitter/nvim-treesitter',
		-- 禁用插件
		--disable = true,
		build = ':TSUpdate',
		config = function()
			require('plugin.treesitter')
		end
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			require('plugin.lspconfig')
		end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp', --neovim 内置 LSP 客户端的 nvim-cmp 源
			--以下插件可选，可以根据个人喜好删减
			--'onsails/lspkind-nvim', --美化自动完成提示信息
			'hrsh7th/cmp-buffer', --从buffer中智能提示
			--'octaltree/cmp-look', --用于完成英语单词
			'hrsh7th/cmp-path', --自动提示硬盘上的文件
			--'hrsh7th/cmp-calc', --输入数学算式（如1+1=）自动计算
			--'f3fora/cmp-spell', --nvim-cmp 的拼写源基于 vim 的拼写建议
			--'hrsh7th/cmp-emoji', --输入: 可以显示表情
			--'hrsh7th/cmp-cmdline', --cmp-cmdline 命令行补全
		}
	},
	-- git信息
	{
		'f-person/git-blame.nvim',
		keys = {
			{ '<leader>l', ':GitBlameToggle<CR>' },
		},
		config = function()
			require('plugin.git-blame')
		end
	},
	-- plist文件支持
	{
		'darfink/vim-plist', 
		ft = 'plist'
	},
	--term
	{
		'akinsho/toggleterm.nvim',
		config = function()
			require('plugin.toggleterm')
		end
	},
	-- 补全菜单 nerd font 支持
	{
		'onsails/lspkind-nvim', 
		config = function()
			require('plugin.lspkind')
		end
	},
	-- 模糊搜索
	{ 
		'ibhagwan/fzf-lua',
		dependencies = {
			'kyazdani42/nvim-web-devicons'
		},
		keys = {
			{ '<leader>f', ':lua require("fzf-lua").files()<CR>' },
			{ '<leader>g', ':lua require("fzf-lua").live_grep()<CR>' },
		},
		config = function()
			require('plugin.fzf-lua')
		end
	},
	--提示栏
	--{
	--	"folke/noice.nvim",
	--	event = "VeryLazy",
	--	opts = {
	--	},
	--	dependencies = {
	--		"MunifTanjim/nui.nvim",
	--		"rcarriga/nvim-notify",
	--	},
	--	config = function()
	--		require('plugin.notice')
	--	end
	--}
})
