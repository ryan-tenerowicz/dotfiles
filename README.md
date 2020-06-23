# Install Repos

Vim
```
sudo apt remove vim vim-runtime gvim


sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git xclip fonts-powerline xdg-utils curl nodejs

./configure --with-features=huge --enable-python3interp=yes

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim

npm -g install instant-markdown-d
```

Markdown
```
npm -g install instant-markdown-d

xdg-utils
curl
nodejs
```

i3
```
Need to install version 4.18 for no wraparound
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2020.02.03_all.deb keyring.deb SHA256:c5dd35231930e3c8d6a9d9539c846023fe1a08e4b073ef0d2833acd815d80d48

(root)
dpkg -i ./keyring.deb
 echo "deb https://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list
apt update
apt install i3

curl
jq
feh
```

bash
```
git clone https://github.com/calid/bash.git -b modestrs --recurse-submodules
cd bash; ./configure
sudo make install

/etc/shells
chsh -s /usr/local/bin/bash
```

zsh
```
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

vim .zinit/plugins/softmoth---zsh-vim-mode/zsh-vim-mode.plugin.zsh
# comment out the if statement on line 497-500
```

neovim
```
https://github.com/neovim/neovim/releases Download appimage

sudo cp ./nvim.appimage /usr/bin/nvim
pip3 install pynvim --upgrade 

Plug Install
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
:PlugInstall
:CocInstall coc-python

```

## Touchpad Gestures
https://github.com/bulletmark/libinput-gestures

```
sudo gpasswd -a $USER input
sudo apt-get install xdotool wmctrl libinput-tools
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures && sudo make install
libinput-gestures-setup start
```

## YouCompleteMe
https://github.com/ycm-core/YouCompleteMe

```
sudo apt install build-essential cmake python3-dev
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clangd-completer 


pip3 install bandit mypy flake8 vulture yapf isort
```

https://github.com/so-fancy/diff-so-fancy#markemptylines
