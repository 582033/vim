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
	echo -e "执行命令 => $1\n"
	$($1)
	if [ -e "$2" ];then
		echo -e "$2\n"
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
	packer_path="$HOME/.local/share/nvim/site/pack/packer"
	packer_start="$packer_path/start"
	packer_opt="$packer_path/opt"
	date=$(date +%s)
	nvim_backup="/tmp/nvim_$date"
	if [ -d $packer_path ]; then
		cmd "mv $HOME/.local/share/nvim/ $nvim_backup" "Packer目录已存在,旧目录已备份至$nvim_backup"
	fi
	cmd "git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_start/packer.nvim"

	cmd "mkdir $packer_opt"
	cmd "cp -r $packer_start/packer.nvim $packer_opt"
	#nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	#nvim -c 'autocmd User quitall' -c 'TSInstall vim go lua' -c 'CocInstall coc-json coc-go coc-snippets'
	#todo 修复 coc-snippets报错
	#cmd "pip install pynvim"
}

setup_package_manager() {
	package_manager="Lazy"
	date=$(date +%s)
	data_path="$HOME/.local/share/nvim"
	if [ -d $data_path ]; then
		nvim_data_backup="/tmp/nvim_data_$date"
		cmd "mv $HOME/.local/share/nvim/ $nvim_data_backup" "$package_manager数据目录已存在,旧目录已备份至$nvim_data_backup"
	fi
	state_path="$HOME/.local/state/nvim"
	if [ -d $state_path ]; then
		nvim_state_backup="/tmp/nvim_state_$date"
		cmd "mv $HOME/.local/state/nvim/ $nvim_state_backup" "$package_manager状态目录已存在,旧目录已备份至$nvim_state_backup"
	fi
	test -f lazy-lock.json || cmd "rm -f lazy-lock.json"
	cmd "git clone https://github.com/folke/lazy.nvim.git $data_path/lazy.nvim"
	echo "下载完成, 执行插件安装..."
	#nvim -c '+Lazy! sync' -c 'quitall'
	nvim -c 'autocmd User Lazy sync' -c 'quitall'
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


if command -v nvim >/dev/null 2>&1; then
	echo "nvim已安装, 开始安装插件..."
else
	echo "nvim未安装"
	exit
fi

vim_version=$(nvim --version | grep NVIM\ v | sed 's/v//g' | awk '{print $2}')
if version_ge $vim_version 0.5; then
	setup_package_manager #安装包管理工具,并克隆预置插件
	create_vim_tmp_dir  #创建vim缓存目录

	if [ "$1" = 'yjiang' ];then
		yjiang_symlinks     #自用习惯
	fi

	if [ ! -x "$(command -v rg)" ]; then
		echo "某些插件依赖\`ripgrep\`, 请安装\`ripgrep\`"
	fi

	if [ ! -x "$(command -v fzf)" ]; then
		echo "某些插件依赖\`fzf\`, 请安装\`fzf\`"
	fi
else
	echo "nvim版本过低,请升级到0.5+"
fi
echo "Done."

