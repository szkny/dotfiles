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
sudo apt install -y silversearcher-ag
sudo apt install -y ripgrep
sudo apt install -y universal-ctags
sudo apt install -y trash-cli

## install rust / cargo
echo 'install rust / cargo..'
curl https://sh.rustup.rs -sSf | sh
. "$HOME/.cargo/env"

## install cargo libs
echo 'install cargo packages..'
cargo install exa bat rm-improved \
  code-minimap git-delta zoxide viu
## cargo install deno

## install rtx
echo 'install rtx..'
curl https://rtx.jdx.dev/install.sh | sh
eval "$(~/.local/share/rtx/bin/rtx activate zsh)"
rtx completion zsh > /usr/local/share/zsh/site-functions/_rtx

## install python
echo 'install python..'
rtx use -g python@3.11.0 python@2.7.15

## install python packages
pip3 install -U pip
pip2 install -U pip
pip install pandas

## install node.js
echo 'install node.js..'
rtx use -g node@18.16.0
npm install -g prettier

## install go
echo 'install go..'
rtx use -g go@latest

## install fzf
echo 'install cargo packages..'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

## install ghq
echo 'install ghq..'
go install github.com/x-motemen/ghq@latest
mkdir -p ~/ghq

## install lazygit
echo 'install lazygit..'
go install github.com/jesseduffield/lazygit@latest
mkdir -p ~/.config/lazygit
ln -s ~/dotfiles/lazygit/config.yml ~/.config/lazygit/config.yml

## install ranger-cli
echo 'install ranger-cli..'
sudo apt install -y python3-setuptools python3-distutils file
mkdir -p ~/Project
git clone https://github.com/ranger/ranger ~/Project/ranger
cd ~/Project/ranger
sudo make install
git clone https://github.com/alexanderjeurissen/ranger_devicons \
  ~/.config/ranger/plugins/ranger_devicons
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
ln -s ~/dotfiles/nvim/init.lua ~/.config/nvim/
ln -s ~/dotfiles/nvim/lua ~/.config/nvim/
# ### for coc-nvim
ln -s ~/dotfiles/nvim/coc-settings.json ~/.config/nvim/
pip install -U jedi-language-server
# sudo apt install terraform-ls
### for treesitter
cargo install tree-sitter-cli

## install skk
mkdir -p ~/.skk && cd ~/.skk
wget https://skk-dev.github.io/dict/SKK-JISYO.L.gz && gunzip SKK-JISYO.L.gz
cd ~

## mocword
cargo install mocword
mkdir -p ~/.mocword
cd ~/.mocword
curl -LO https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
gzip -d mocword.sqlite.gz

## tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## sheldon
cargo install sheldon --locked
ln -s ~/dotfiles/sheldon ~/.config/

## starship prompt
curl -sS https://starship.rs/install.sh | sh
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml

