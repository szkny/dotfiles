#!/usr/bin/zsh

## tz-data
echo 'setup time zone..'
export TZ=Asia/Tokyo
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y tzdata
sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
sudo echo $TZ > /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata

## install basic apt-get packages
echo 'install basic apt-get packages..'
sudo apt-get install -y build-essential libbz2-dev libdb-dev \
  libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
  libncursesw5-dev libsqlite3-dev libssl-dev \
  zlib1g-dev uuid-dev tk-dev
sudo apt-get install -y git curl zip unzip wget bsdmainutils gawk
sudo apt-get install -y silversearcher-ag
sudo apt-get install -y ripgrep
sudo apt-get install -y universal-ctags
sudo apt-get install -y trash-cli

## install rust / cargo
echo 'install rust / cargo..'
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable --profile default
. "$HOME/.cargo/env"

## install cargo libs
echo 'install cargo packages..'
cargo install eza bat rm-improved \
  code-minimap git-delta zoxide viu fd-find
## cargo install deno

## install mise
echo 'install mise..'
curl https://mise.jdx.dev/install.sh | sh
eval "$(~/.local/bin/mise activate zsh)"
mise completion zsh > ./_mise
sudo mkdir -p /usr/local/share/zsh/site-functions
sudo mv ./_mise /usr/local/share/zsh/site-functions/_mise

## install python
echo 'install python..'
mise use -g python@3.12.0 python@2.7.15
eval "$(~/.local/bin/mise activate zsh)"

## install python packages
pip3 install -U pip
pip2 install -U pip
pip install pandas poetry

## python code linter
ln -s ~/dotfiles/python_syntax_checker/pycodestyle ~/.config/pycodestyle

## install node.js
echo 'install node.js..'
mise use -g node@18.16.0
eval "$(~/.local/bin/mise activate zsh)"
npm install -g prettier

## install go
echo 'install go..'
mise use -g go@latest
eval "$(~/.local/bin/mise activate zsh)"

## install ghq
echo 'install ghq..'
go install github.com/x-motemen/ghq@latest
mkdir -p ~/ghq

## install lazygit
echo 'install lazygit..'
go install github.com/jesseduffield/lazygit@latest
mkdir -p ~/.config/lazygit
ln -s ~/dotfiles/lazygit/config.yml ~/.config/lazygit/config.yml

## install fzf
echo 'install fzf..'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

## install ranger-cli
echo 'install ranger-cli..'
sudo apt-get install -y python3-setuptools python3-distutils file
mkdir -p ~/Project
git clone https://github.com/ranger/ranger ~/Project/ranger
cd ~/Project/ranger
sudo make install
cp -r ~/dotfiles/ranger ~/.config
cd ~

## install neovim
echo 'install neovim..'
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update -y
sudo apt-get install -y neovim
sudo apt-get install -y python3-neovim
sudo apt-get install -y luarocks
pip2 install neovim
pip3 install neovim
npm install -g neovim
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/nvim/init.lua ~/.config/nvim/
ln -s ~/dotfiles/nvim/lua ~/.config/nvim/
# ### for coc-nvim
ln -s ~/dotfiles/nvim/coc-settings.json ~/.config/nvim/
pip install -U jedi-language-server
# sudo apt-get install terraform-ls
### for treesitter
cargo install tree-sitter-cli

## install skk
mkdir -p ~/.skk && cd ~/.skk
wget https://skk-dev.github.io/dict/SKK-JISYO.L.gz && gunzip SKK-JISYO.L.gz
cd ~

## install mocword
cargo install mocword
mkdir -p ~/.mocword
cd ~/.mocword
curl -LO https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
gzip -d mocword.sqlite.gz

## install tmux
sudo apt-get install -y tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## install sheldon
cargo install sheldon --locked
ln -s ~/dotfiles/sheldon ~/.config/

## install starship prompt
curl -sS https://starship.rs/install.sh | sh
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml

## install jq / yq
sudo apt-get -y install jq
go install github.com/mikefarah/yq/v4@latest

## install w3m
sudo apt-get install -y w3m
mkdir -p ~/.w3m
ln -s ~/dotfiles/w3m/keymap ~/.w3m/keymap

## git-cz
npm install -g git-cz

# ## install docker
# sudo apt-get install -y ca-certificates curl gnupg lsb-release
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# sudo apt-get update
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# sudo dockerd
# sudo usermod -aG docker $USER
# newgrp docker

# ## install flutter
# export ANDROID_SDK_ROOT=$HOME/Project/Android/sdk
# export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
# export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
# export PATH=$PATH:$HOME/flutter/bin
#
# sudo apt-get install -y xz-utils libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev openjdk-17-jdk
# git clone https://github.com/flutter/flutter.git -b stable ~/flutter
# flutter config --jdk-dir=/usr/lib/jvm/java-17-openjdk-amd64
# flutter doctor
# sudo snap install android-studio --classic
# sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
# sdkmanager "system-images;android-35;google_apis;x86_64"
# sdkmanager "emulator"
# # avdmanager create avd -n flutter_emulator -k "system-images;android-35;google_apis;x86_64"

# ### chrome
# mkdir -p ~/Project/chrome
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o ~/Project/chrome/google-chrome-stable_current_amd64.deb
# sudo apt-get install -y ~/Project/chrome/google-chrome-stable_current_amd64.deb
