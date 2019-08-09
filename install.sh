#!/usr/bin/env sh

##############################
app_dir="$HOME/.vim"
#VUNDLE_URI="https://github.com/gmarik/vundle.git"
###############################

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi  
}

appendif() {
    if [ -e "$2" ]; then
        cat $1 >> $2
    fi
}

create_symlinks() {
    endpath="$app_dir"

    appendif "$endpath/vimrc"              "$HOME/.vimrc"
    appendif "$endpath/bashrc"         "$HOME/.bashrc"
}

yjiang_symlinks() {
    endpath="$app_dir"
    lnif "$endpath/bash_local"              "$HOME/.bash_local"
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

if version_ge $vim_version 7.3;then
    #do_backup   "原有vim配置已备份至 .vim.`date +%Y%m%d%S`" "$HOME/.vim" "$HOME/.vimrc"
    create_symlinks     #创建配置软链接
    create_vim_tmp_dir  #创建vim缓存目录
    echo "Done."
else
    echo "Vim version must be 7.3+."
fi
