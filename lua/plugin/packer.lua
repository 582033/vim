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
		'neoclide/coc.nvim', 
		branch = 'release'
	}
	use {
		'dense-analysis/ale', 
		cmd = 'ALEEnable',
		ft = { 'go' },
		config = 'vim.cmd[[ALEEnable]]'
	}

	--代码片段工具
	use {
		'honza/vim-snippets'
	}

	--plist文件支持
	use {
		'darfink/vim-plist', 
		ft = { 'plist' }
	}

	--启动界面快速打开最近的文件
	use 'mhinz/vim-startify'

    --[[
	--term
	use {
		'akinsho/toggleterm.nvim',
		config = function()
			require('plugin.toggleterm')
		end
	}
    --]]
end
)
