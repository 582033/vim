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

#$1 command 
#$2 comment
cmd(){
	echo "执行命令:$1"
	$($1)
	if [ -e "$2" ];then
		echo $2
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

setup_packer() {
	packer_patch="$HOME/.local/share/nvim/site/pack/packer"
	date=$(date +%s)
	nvim_backup="/tmp/nvim_$date"
	if [ -d $packer_patch ]; then
		cmd "mv $HOME/.local/share/nvim/ $nvim_backup" "Packer目录已存在,旧目录已备份至$nvim_backup"
	fi
	cmd "git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_patch/start/packer.nvim"
	#nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

create_vim_tmp_dir(){
    tmp_dir="$base_dir/.vim_tmp"

    if [ ! -d "$tmp_dir" ]; then
        cmd "mkdir -p $tmp_dir"
    fi
}

version_ge(){
    #echo $@
    test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"
}

vim_version=$(nvim --version | grep NVIM\ v | sed 's/v//g' | awk '{print $2}')

if version_ge $vim_version 0.5; then
    setup_packer      #安装packer,并克隆预置插件
    create_vim_tmp_dir  #创建vim缓存目录
    if [ "$1" = 'yjiang' ];then
        yjiang_symlinks     #自用习惯
    fi
fi
echo "Done."
