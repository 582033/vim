-- 插件安装目录
-- -- ~/.local/share/nvim/site/pack/packer/
function file_exists(path)
	local file = io.open(path, "rb")
	if file then file:close() end
	return file ~= nil
end

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if not file_exists(install_path) then
	print(install_path.."目录不存在")
	print("克隆Packer插件管理器...\n")
	vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	--vim.cmd('packadd packer.nvim')

	local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
	if not string.find(vim.o.runtimepath, rtp_addition) then
		vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
	end
	vim.notify("Pakcer.nvim 安装完毕")
end

-- pcall(require, "packer"): 捕获 `require "packer"`的执行错误
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("没有安装 packer.nvim")
	return
end

packer.startup({
	function(use)
		-- 包管理工具Packer
		use 'wbthomason/packer.nvim'
		-- Copilot
		use 'github/copilot.vim'
		--启动界面快速打开最近的文件
		use 'mhinz/vim-startify'
		-- nginx 配置文件高亮
		use 'chr4/nginx.vim'
		-- systemd 系统文件高亮
		use 'Matt-Deacalion/vim-systemd-syntax'
		-- php
		--use 'spf13/PIV', { 'for': 'php' }
		--代码片段工具
		use 'hrsh7th/cmp-vsnip'
		use 'hrsh7th/vim-vsnip'
		use 'hrsh7th/vim-vsnip-integ'
		use {
			'kyazdani42/nvim-tree.lua',
			requires = {
				'kyazdani42/nvim-web-devicons'
			},
			setup = function()
				vim.api.nvim_set_keymap('n', '<c-e>', ':NvimTreeToggle<CR>', {})
				vim.api.nvim_set_keymap('n', '<c-d>', ':NvimTreeFindFile<CR>', {})
			end,
			config = function()
				require('plugin.nvimtree')
			end

		}
		use {
			'plasticboy/vim-markdown', 
			ft = { 'markdown' }
		}
		--主题
		use {
			--'lifepillar/vim-solarized8',
			'sainnhe/sonokai',
			require = {
				'rktjmp/lush.nvim'
			},
			config = function()
				vim.cmd('colorscheme sonokai')
				vim.cmd('hi Normal ctermfg=white ctermbg=black')
			end
		}
		--状态栏
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			config = function()
				require('lualine').setup({
					theme = 'gruvbox'
				})
			end
		}
		--python
		use {
			'hynek/vim-python-pep8-indent', 
			ft = { 'python' }
		}
		--go
		use {
			'fatih/vim-go', 
			ft = {'go'},
			cmd = 'GoUpdateBinaries'
		}
		use {
			'buoto/gotests-vim', 
			ft = { 'go' }
		}
		-- 语法高亮(多语言支持); 语法树链接
		-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
		use {
			'nvim-treesitter/nvim-treesitter',
			-- 禁用插件
			--disable = true,
			--cmd = 'TSUpdate',
			config = function()
				require('plugin.treesitter')
			end
		}
		use {
			'neovim/nvim-lspconfig',
			config = function()
				require('plugin.lspconfig')
			end
		}
		use {
			'hrsh7th/nvim-cmp',
			requires = {
				'hrsh7th/cmp-nvim-lsp', --neovim 内置 LSP 客户端的 nvim-cmp 源
				--以下插件可选，可以根据个人喜好删减
				--'onsails/lspkind-nvim', --美化自动完成提示信息
				'hrsh7th/cmp-buffer', --从buffer中智能提示
				--'octaltree/cmp-look', --用于完成英语单词
				'hrsh7th/cmp-path', --自动提示硬盘上的文件
				--'hrsh7th/cmp-calc', --输入数学算式（如1+1=）自动计算
				--'f3fora/cmp-spell', --nvim-cmp 的拼写源基于 vim 的拼写建议
				--'hrsh7th/cmp-emoji', --输入: 可以显示表情
				'hrsh7th/cmp-cmdline', --cmp-cmdline 命令行补全
			}
		}
		-- git信息
		use {
			'APZelos/blamer.nvim',
			config = function()
				require('plugin.blamer')
			end
		}
		-- plist文件支持
		use {
			'darfink/vim-plist', 
			ft = { 'plist' }
		}
		--term
		use {
			'akinsho/toggleterm.nvim',
			config = function()
				require('plugin.toggleterm')
			end
		}
		use {
			'onsails/lspkind-nvim', -- 补全菜单 nerd font 支持
			config = function()
				require('plugin.lspkind')
			end
		}
		use { 
			'ibhagwan/fzf-lua',
			run = './install --bin',
			setup = function()
				vim.api.nvim_set_keymap('n', '<c-p>f', "<cmd>lua require('fzf-lua').files()<CR>", { })
				vim.api.nvim_set_keymap('n', '<c-p>g', "<cmd>lua require('fzf-lua').live_grep()<CR>", { })
			end,
			config = function()
				require('plugin.fzf-lua')
			end
		}
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end
		}
	}
})
