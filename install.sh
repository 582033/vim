#!/usr/bin/env bash

##############################
app_dir="$HOME/.vim"
yjiang_dir="$app_dir/habit"
###############################

do_backup() {
    if [ -e "$2" ] || [ -e "$3" ] || [ -e "$4" ]; then
        today=`date +%Y%m%d_%s`
        for i in "$2" "$3" "$4"; do
            [ -e "$i" ] && [ ! -L "$i" ] && mv "$i" "$i.$today";
        done
    fi
    echo $1
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi  
}

create_symlinks() {
    lnif "$app_dir/vimrc"              "$HOME/.vimrc"
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
    if [ ! -e "$HOME/.vim/autoload" ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        install_arguments="+PlugInstall +PlugClean +qall"
    else
        install_arguments="+PlugUpgrade +PlugInstall +PlugClean +qall"
    fi
    vim -u "$HOME/.vimrc" $install_arguments
}

create_vim_tmp_dir(){
    tmp_dir="$app_dir/.vim_tmp"

    if [ ! -d "$tmp_dir" ]; then
        mkdir -p "$tmp_dir"
    fi
}

version_ge(){
    test "$(echo "$@" | tr " " "\n" | sort -r | head -n 1)" == "$1";
}

vim_version=$(vim --version | grep Vi | awk '{print $5}')

if version_ge $vim_version 8.1;then
    #do_backup   "原有vim配置已备份至 .vim.`date +%Y%m%d%S`" "$HOME/.vim" "$HOME/.vimrc"
    create_symlinks     #创建配置软链接
    setup_vim_plug      #安装vim-plug,并克隆预置插件
    create_vim_tmp_dir  #创建vim缓存目录
    #yjiang_symlinks     #自用习惯
    echo "Done."
else
    echo "Vim version must be 8.1+."
fi
