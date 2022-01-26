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
	vim.cmd('packadd packer.nvim')
end

vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
	use {
		'wbthomason/packer.nvim',
	}

	use {
		'preservim/nerdtree',
		setup = function()
			vim.api.nvim_set_keymap('', '<c-e>', ':NERDTreeToggle<CR>', {})
			vim.api.nvim_set_keymap('', '<c-d>', ':NERDTreeFind<CR>', {})
		end
	} 

	use {
		'plasticboy/vim-markdown', 
		ft = { 'markdown' }
	}

	--主题
	use {
		'lifepillar/vim-solarized8',
		--'sainnhe/gruvbox-material',
		config = function()
			vim.g.solarized_termtrans = 1
			vim.g.solarized_termcolors = 256
			vim.o.background = 'dark'
			vim.cmd('syntax enable')
			vim.cmd('colorscheme solarized8')
		end
	}

	--可视化缩进
	--use 'nathanaelkane/vim-indent-guides'
	use 'chr4/nginx.vim'

	--[[
	--语法检查
	use {
		'scrooloose/syntastic',
		config = function()
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
		end
	}
	--]]

	--systemd 系统文件高亮
	use 'Matt-Deacalion/vim-systemd-syntax'

	--php
	--use 'spf13/PIV', { 'for': 'php' }
	use {
		'StanAngeloff/php.vim',
		ft = { 'php' }
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
	use {
		'nvim-treesitter/nvim-treesitter',
		-- 禁用插件
		--disable = true,
		--cmd = 'TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup{
				-- 启用高亮
				highlight = {
					enable = true,
					-- 禁用 vim 基于正则达式的语法高亮，太慢
					additional_vim_regex_highlighting = false
				}
			}
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
	use {
		'hrsh7th/vim-vsnip',
		requires = {
			'hrsh7th/cmp-vsnip',
		},
		config = function()
			require('plugin.snippets')
		end
	}
	--[[
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/vim-vsnip'
	use {
		'dense-analysis/ale',
		ft = { 'go' },

	}
	--]]
	--gitlens
	use {
		'APZelos/blamer.nvim',
		config = function()
			require('plugin.blamer')
		end
	}

	--plist文件支持
	use {
		'darfink/vim-plist', 
		ft = { 'plist' }
	}

	--启动界面快速打开最近的文件
	use 'mhinz/vim-startify'

    --[[
	--代码片段工具
	use {
		'honza/vim-snippets',
		-- Lazy loading
		opt = true
	}

	--term
	use {
		'akinsho/toggleterm.nvim',
		config = function()
			require('plugin.toggleterm')
		end
	}
    --]]
    	use {
		'onsails/lspkind-nvim', -- 补全菜单 nerd font 支持
		config = function()
			require('plugin.lspkind')
		end
	}
	use 'uarun/vim-protobuf'
end
)
