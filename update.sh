#!/bin/bash

cp -r ~/.config/i3 .
#cp -r ~/.config/i3status .
cp -r ~/.config/i3blocks .

cp ~/.vimrc .
cp -r ~/.vim .
rm -rf ./.vim/plugins/
#cp -r ~/.config/nvim .
#rm -rf ./nvim/plugins/

#cp ~/.bashrc .
#cp ~/.inputrc .
#cp ~/.bash_aliases .
cp ~/.zshrc .
cp -r ~/.zsh .
rm ./.zsh/.cwd

#cp ~/.config/libinput-gestures.conf .
#cp ~/.config/redshift.conf .
cp ~/.xbindkeysrc .
cp -r ~/.config/background .
cp -r ~/.scripts .
cp ~/.Xmodmap .
