local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	vim.api.nvim_command('packadd packer.nvim')
end

vim.cmd('packadd packer.nvim')

require('packer').startup(function()
	use 'vim-scripts/matchit.zip'
	--use 'vim-scripts/taglist.vim'
	use 'majutsushi/tagbar'
	use { 
		'vim-scripts/JavaScript-Indent', 
		ft = { 'php', 'html', 'javascript' }
	}
	use 'preservim/nerdtree'
	use {
		'plasticboy/vim-markdown', 
		ft = { 'markdown' }
	}
	use 'kien/ctrlp.vim'

	--主题
	--use 'altercation/vim-colors-solarized'
	--use 'fatih/molokai'
	--use 'morhetz/gruvbox'
	use 'lifepillar/vim-solarized8'

	--可视化缩进
	--use 'nathanaelkane/vim-indent-guides'
	use 'chr4/nginx.vim'

	--语法检查
	use 'scrooloose/syntastic'

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
		ft = {'php'},
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
		ft = { 'go' }
	}

	--代码片段工具
	use 'honza/vim-snippets'

	--plist文件支持
	use {
		'darfink/vim-plist', 
		ft = { 'plist' }
	}

	--启动界面快速打开最近的文件
	use 'mhinz/vim-startify'

	--lua语法支持
	use 'vim-scripts/luainspect.vim'
	use 'xolox/vim-misc'
	use 'xolox/vim-lua-ftplugin'
end
)

require('plugins/nerdtree')
