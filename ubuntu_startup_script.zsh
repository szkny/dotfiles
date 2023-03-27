#!/usr/bin/zsh
## install basic apt packages
echo 'install basic apt packages..'
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y build-essential libbz2-dev libdb-dev \
  libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
  libncursesw5-dev libsqlite3-dev libssl-dev \
  zlib1g-dev uuid-dev tk-dev
sudo apt install -y git curl zip unzip wget bsdmainutils gawk
sudo apt install -y tmux
sudo apt install -y golang
sudo apt install -y silversearcher-ag
sudo apt install -y universal-ctags
sudo apt install -y trash-cli

## install rust / cargo
echo 'install rust / cargo..'
curl https://sh.rustup.rs -sSf | sh
. "$HOME/.cargo/env"

## install cargo libs
echo 'install cargo packages..'
. ~/.zshrc
cargo install exa bat rm-improved code-minimap git-delta
## cargo install deno

## mocword
cargo install mocword
mkdir -p ~/.mocword
cd ~/.mocword
curl -LO https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
gzip -d mocword.sqlite.gz

## install python
echo 'install python..'
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
. ~/.zshrc
pyenv install --verbose 3.6.5
pyenv install --verbose 2.7.15
pyenv global 3.6.5 2.7.15

## install python packages
pip3 install -U pip
pip2 install -U pip
pip install pandas

## install node.js
echo 'install node.js..'
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
. ~/.zshrc
nvm install 14.17.1
npm install -g prettier@2.8.0

## install fzf
echo 'install cargo packages..'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

## install ghq
echo 'install cargo packages..'
go install github.com/x-motemen/ghq@latest
mkdir -p ~/ghq

## install ranger-cli
echo 'install ranger-cli..'
sudo apt install -y python3-setuptools python3-distutils file
mkdir -p ~/Project
git clone https://github.com/ranger/ranger ~/Project/ranger
cd ~/Project/ranger
sudo make install
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
cd ~

## install neovim
echo 'install neovim..'
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update -y
sudo apt install -y neovim
sudo apt install -y python3-neovim
pip2 install neovim
pip3 install neovim
npm install -g neovim
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/nvim/* ~/.config/nvim/
nvim --headless +PlugInstall +qall

## for coc-nvim
sudo apt install terraform-ls

## install skk
mkdir -p ~/.skk && cd ~/.skk
wget https://skk-dev.github.io/dict/SKK-JISYO.L.gz && gunzip SKK-JISYO.L.gz
cd ~

## synbolic link for tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

## zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

## starship prompt
curl -sS https://starship.rs/install.sh | sh
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml

