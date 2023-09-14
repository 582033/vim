Vim 自动化配置
===
> 用以实现vim bash git tmux tmuxp的快速配置

### **已更新为Neovim, vim版本不再使用(备份到vim-bak分支)**

### 初始支持

* 使用[packer](https://github.com/wbthomason/packer.nvim)对插件进行管理
* 默认支持GO/PHP/Python/JS/CSS/HTML/NGINX语法高亮
* 更多配置详情请看init.lua

### 依赖

* git
* neovim

### 安装
    $ cd ~/ && git clone https://github.com/582033/vim.git .vim
    $ ./install.sh
    
### 除vim外其他个人习惯的配置

* bashrc
* tmux >= 2.9
* tmuxp
* gitconfig

#### Nerd Fonts
```
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font
```

### 已知问题
