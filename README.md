### **(2021年12月8日)已更新为Neovim, vim版本不再使用; 旧分支移动到vim-bak**
---
NeoVim 自动化配置
===
> 用以实现neovim bash git tmux tmuxp的快速配置

---

### 初始支持

* 使用[lazy.nvim](https://github.com/folke/lazy.nvim)对插件进行管理
* 默认支持GO/PHP/Python/JS/CSS/HTML/NGINX/MARKDOWN/LUA/BASH语法高亮
* 更多配置详情请看lua/plugin/lazy.lua

### 依赖

* git >= 2.19.0
* neovim >= 0.8
* Nerd Font(参考[https://github.com/ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts))

### 安装
    $ git clone https://github.com/582033/vim.git .config/nvim && cd ~/.config/nvim
    $ ./install.sh
    
### 除nvim外其他个人习惯的配置

* bashrc
* tmux >= 2.9
* tmuxp
* gitconfig
