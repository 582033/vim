#!/bin/sh

##############################
app_dir="$HOME/.vim"
VUNDLE_URI="https://github.com/gmarik/vundle.git"
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

upgrade_repo() {
      if [ "$1" = "$app_name" ]; then
          cd "$app_dir" &&
          git pull origin "$git_branch"
      fi

      if [ "$1" = "vundle" ]; then
          cd "$HOME/.vim/bundle/vundle" &&
          git pull origin master
      fi
}

clone_vundle() {
    if [ ! -e "$HOME/.vim/bundle/vundle" ]; then
        git clone $VUNDLE_URI "$HOME/.vim/bundle/vundle"
    else
        upgrade_repo "vundle"   "Successfully updated vundle"
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi  
}

create_symlinks() {
    endpath="$app_dir"

    if [ ! -d "$endpath/.vim/bundle" ]; then
        mkdir -p "$endpath/.vim/bundle"
    fi

    lnif "$endpath/vimrc"              "$HOME/.vimrc"
    lnif "$endpath/bashrc"             "$HOME/.bashrc"
    lnif "$endpath/tmux.conf"          "$HOME/.tmux.conf"
    lnif "$endpath/tmuxp.yaml"         "$HOME/.tmuxp.yaml"
    lnif "$endpath/gitconfig"         "$HOME/.gitconfig"
}

setup_vundle() {
    system_shell="$SHELL"
    export SHELL='/bin/sh'
    vim -u "$HOME/.vimrc" +BundleInstall! +BundleClean +qall
    export SHELL="$system_shell"
}

create_vim_tmp_dir(){
    tmp_dir="$app_dir/.vim_tmp"

    if [ ! -d "$tmp_dir" ]; then
        mkdir -p "$tmp_dir"
    fi
}


vim_version=$(vim --version | grep Vi | awk '{print $5}')
r=$(echo "$vim_version >= 7.3" | bc)
if [ $r != 1 ];then
    echo "Vim version must be 7.3+."
else
    #do_backup   "原有vim配置已备份至 .vim.`date +%Y%m%d%S`" "$HOME/.vim" "$HOME/.vimrc"
    clone_vundle        #安装vundle
    create_symlinks     #创建配置软链接
    setup_vundle        #克隆预置插件
    create_vim_tmp_dir  #创建vim缓存目录
fi
