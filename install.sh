#!/bin/bash

cp .Xmodmap ~

mkdir -p ~/.config
cp ./libinput-gestures.conf ~/.config/
cp ./redshift.conf ~/.config/
cp -r ./background ~/.config/
cp -r ./i3 ~/.config/
cp -r ./i3status ~/.config/
cp -r ./i3blocks ~/.config/

cp -r ./nvim ~/.config/
#cp .vimrc ~
#cp -r ./.vim ~

cp .zshrc ~
cp -r ./.zsh ~
#cp .bashrc ~
#cp .inputrc ~
#cp .bash_aliases ~

cp -r .scripts/ ~
