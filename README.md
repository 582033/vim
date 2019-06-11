Vim 自动化配置
===
> 用以实现vim bash git tmux tmuxp的快速配置

### 初始支持

* 使用[vim-plug](https://github.com/junegunn/vim-plug)对插件进行管理
* 默认支持PHP/Python/JS/CSS/HTML/NGINX语法高亮
* 更多配置详情请看vimrc

### 依赖

* git
* vim >= v7.3

### 安装
    $ cd ~/ && git clone https://github.com/582033/vim.git .vim
    $ ./install.sh
    
### 除vim外其他个人习惯的配置

* bashrc
* tmux >= 2.9
* tmuxp
* gitconfig


### 已知问题

* spf13/piv插件会导致偶尔php语法高亮失效,解决方法参见[VIM PIV插件导致的PHP文件偶尔丢失语法高亮问题](https://yjiang.cn/index.php/archives/1674/)
