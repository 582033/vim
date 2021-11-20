#!/usr/bin/env bash

##############################
base_dir="$HOME/.config"
app_dir="$base_dir/nvim"
yjiang_dir="$app_dir/habit"
###############################

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi  
}

yjiang_symlinks() {
    lnif "$yjiang_dir/bash_local"         "$HOME/.bash_local"
    lnif "$yjiang_dir/bashrc"             "$HOME/.bashrc"
    lnif "$yjiang_dir/editrc"             "$HOME/.editrc"
    lnif "$yjiang_dir/tmux.conf"          "$HOME/.tmux.conf"
    lnif "$yjiang_dir/tmuxp.yaml"         "$HOME/.tmuxp.yaml"
    lnif "$yjiang_dir/gitconfig"          "$HOME/.gitconfig"
    lnif "$yjiang_dir/dircolors"          "$HOME/.dircolors"
}

setup_vim_plug() {
    if [ ! -e "$app_dir/autoload" ]; then
        curl -fLo "$app_dir/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        install_arguments="+PlugInstall +PlugClean +qall"
    else
        install_arguments="+PlugUpgrade +PlugInstall +PlugClean +qall"
    fi
    nvim $install_arguments
}

create_vim_tmp_dir(){
    tmp_dir="$base_dir/.vim_tmp"

    if [ ! -d "$tmp_dir" ]; then
        mkdir -p "$tmp_dir"
    fi
}

version_ge(){
    test "$(echo "$@" | tr " " "\n" | sort -r | head -n 1)" == "$1";
}

vim_version=$(vim --version | grep Vi | awk '{print $5}')

setup_vim_plug      #安装vim-plug,并克隆预置插件
create_vim_tmp_dir  #创建vim缓存目录
if [ "$1" = 'yjiang' ];then
	yjiang_symlinks     #自用习惯
fi

echo "Done."
