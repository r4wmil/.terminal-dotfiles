#!/bin/sh

hascmd() {
	if [ -z $(which "$1") ]; then
		echo "Command '$1' absent"
		return 1
	fi
	echo "Command '$1' present"
	return 0
}

DEPLOY_ACTION=$1

sym() {
	src=$1
	dst_dir=$2
	dst_sym=$3
	if [ "$DEPLOY_ACTION" = "clean" ]; then
		if [ ! -L "$dst_dir/$dst_sym" ]; then
			echo "-> Symlink '$dst_dir/$dst_sym' does not exists."
			return 1;
		fi
		echo "-> Unlinking '$1' -> '$dst_dir/$dst_sym'"
		rm "$dst_dir/$dst_sym"
		return 0;
	else
		if [ -L "$dst_dir/$dst_sym" ]; then
			echo "-> Symlink '$dst_dir/$dst_sym' already exists"
			return 1;
		fi
		echo "-> Linking '$1' -> '$dst_dir/$dst_sym'"
		mkdir -p "$dst_dir"
		ln -s "$src" "$dst_dir/$dst_sym"
		return 0;
	fi
	return 1;
}

CONFIGS=$HOME/.terminal-dotfiles/config

# Terminal
hascmd "git"  && git config --global include.path ~/.terminal-dotfiles/config/gitconfig
if hascmd "zsh"; then
	[ -z $TERMUX__PREFIX ] && chsh -s /bin/zsh || chsh -s zsh
	sym "$CONFIGS/zshrc" "$HOME" ".zshrc"
fi
hascmd "nvim" && sym "$CONFIGS/nvim/init.lua" "$HOME/.config/nvim" "init.lua"
if [ ! -z $TERMUX__PREFIX ]; then
	mv $HOME/.termux $HOME/.termux.bak
	sym "$CONFIGS/termux/termux.properties" "$HOME/.termux"
fi
