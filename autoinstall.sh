#!/bin/bash

I3_LINK="https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2020.02.03_all.deb keyring.deb SHA256:c5dd35231930e3c8d6a9d9539c846023fe1a08e4b073ef0d2833acd815d80d48"
NEOVIM_LINK="https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage"
ST_LINK="https://github.com/ryan-tenerowicz/st.git"
NODEJS_LINK="https://nodejs.org/dist/v12.17.0/node-v12.17.0-linux-x64.tar.xz"
DMENU_LINK="https://github.com/ryan-tenerowicz/dmenu.git"

./install.sh

#install i3
#need 4.18 for no wrap
/usr/lib/apt/apt-helper download-file $I3_LINK

sudo dpkg -i ./keyring.deb
echo "deb https://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list
rm -f keyring.deb

sudo apt update
sudo apt -y install i3 i3blocks curl jq feh xdotool


#install neovim
#need atleast 0.4 for coc features
sudo apt-get -y install wget
wget $NEOVIM_LINK
sudo chmod +x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
sudo apt-get -y install python3-pip
pip3 install pynvim --upgrade

sudo apt-get -y install xdg-utils npm nodejs cmake xbindkeys xclip
sudo npm -g install instant-markdown-d

#Need node later than 12 for coc
#wget $NODEJS_LINK -O nodejs.tar
#tar xvf nodejs.tar
#sudo mv node-v12.17.0-linux-x64/bin/node /usr/bin/node

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --headless +PlugInstall +qall

python3 ~/.config/nvim/plugins/YouCompleteMe/install.py --clangd-completer
sudo apt-get install exuberant-ctags
pip3 install bandit mypy flake8 vulture yapf isort
#nvim --headless +CocInstall coc-python +qall


#install st
git clone $ST_LINK
cd st
sudo apt-get -y install make xorg-dev
sudo make install
cd ..

#install dmenu
git clone $DMENU_LINK
cd dmenu
sudo make install
cd ..

#install zsh
sudo apt-get -y install zsh
chsh -s /usr/bin/zsh

#install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#install virtual env
sudo apt-get -y install python-pip
sudo pip install virtualenvwrapper
