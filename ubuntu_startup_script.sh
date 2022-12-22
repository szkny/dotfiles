# install apt packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential libbz2-dev libdb-dev \
  libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
  libncursesw5-dev libsqlite3-dev libssl-dev \
  zlib1g-dev uuid-dev tk-dev
sudo apt install -y git curl zip unzip
sudo apt install -y golang
sudo apt install -y silversearcher-ag
sudo apt install -y universal-ctags

# install rust / cargo
curl https://sh.rustup.rs -sSf | sh

# install cargo libs
. ~/.zshrc
cargo install exa bat rm-improved code-minimap

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install ghq
go install github.com/x-motemen/ghq@latest

# install python
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
. ~/.zshrc
pyenv install 3.6.5
pyenv install 2.7.15
pyenv global 3.6.5 2.7.15

# install node.js
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
. ~/.zshrc
nvm install 14.17.1

# install neovim
sudo apt install -y neovim
sudo apt install -y python3-neovim
pip2 install neovim
pip3 install neovim
npm install -g neovim
nvim --headless +PlugInstall +qall

