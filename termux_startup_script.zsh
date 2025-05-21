#!/usr/bin/zsh

termux-setup-storage

pkg update && pkg upgrade
pkg install -y pacman patchelf which time ldd tree
pkg install -y termux-exec
pkg install -y termux-tools
pkg install -y termux-app
pkg install -y root-repo
pkg install -y libc++
pkg install -y coreutils
pkg install -y openssl
pkg install -y build-essential make cmake ninja
pkg install -y clang
pkg install -y binutils-is-llvm
pkg install -y wget
pkg install -y netcat-openbsd
pkg install -y pulseaudio
pkg install -y file
pkg install -y golang
pkg install -y nodejs
pkg install -y rust
pkg install -y rustc cargo rustc-nightly
pkg install -y w3m lynx
pkg install -y bat
pkg install -y wol
pkg install -y android-tools

# zsh
pkg install -y zsh
chsh -s zsh

# font
pkg install -y lsd
mkdir -p ~/Project/font
cd ~/Project/font
wget https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip
unzip ./HackGen*.zip
cp ./HackGen*/HackGenConsoleNF-Regular.ttf ~/.termux/font.ttf

# python
pkg install -y python libopenblas libandroid-execinfo patchelf
pip3 install setuptools wheel packaging pyproject_metadata cython meson-python versioneer
MATHLIB=m LDFLAGS="-lpython3.12" pip3 install --no-build-isolation --no-cache-dir numpy
LDFLAGS="-lpython3.12" pip3 install --no-build-isolation --no-cache-dir pandas
pkg install -y matplotlib
pkg install -y tur-repo python-scipy
pip3 install poetry

## python code linter
ln -s ~/dotfiles/python_syntax_checker/pycodestyle ~/.config/pycodestyle

# cargo
cargo install rm-improved code-minimap git-delta zoxide viu fd-find

# neovim
pkg install -y neovim
pip2 install neovim
pip3 install neovim
npm install -g neovim
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/nvim/init.lua ~/.config/nvim/
ln -s ~/dotfiles/nvim/lua ~/.config/nvim/
## for treesitter
cargo install tree-sitter-cli

# tmux
pkg install -y tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ranger
pkg install -y ranger screen
mkdir -p ~/.config
cp -r ~/dotfiles/ranger ~/.config/

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# ghq
go install github.com/x-motemen/ghq@latest
mkdir -p ~/ghq

# lazygit
go install github.com/jesseduffield/lazygit@latest
mkdir -p ~/.config/lazygit
ln -s ~/dotfiles/lazygit/config.yml ~/.config/lazygit/config.yml

# sheldon
cargo install sheldon --locked
ln -s ~/dotfiles/sheldon ~/.config/

# starship
curl -sS https://starship.rs/install.sh | sh
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml

# jq / yq
pkg install -y jq
go install github.com/mikefarah/yq/v4@latest

# skk
mkdir -p ~/.skk && cd ~/.skk
wget https://skk-dev.github.io/dict/SKK-JISYO.L.gz && gunzip SKK-JISYO.L.gz
cd ~

# mocword
cargo install mocword
mkdir -p ~/.mocword && cd ~/.mocword
curl -LO https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
gzip -d mocword.sqlite.gz
cd ~

# rsync
pkg install -y rsync

# audio
pkg install -y mpv
pip install yewtube
ln -s ~/dotfiles/mpv ~/.config/

# git-cz
npm install -g git-cz

## repomix
npm install -g repomix

# sshd
pkg install -y openssh
passwd

# GUI env
pkg install -y x11-repo termux-x11-nightly xfce4 xfce4-goodies
pkg install -y tur-repo chromium firefox
## font
pkg install -y fontconfig
mkdir -p ~/.config/fontconfig
cp ~/dotfiles/fontconfig/fonts.conf ~/.config/fontconfig/fonts.conf
## GUI startup script
mkdir -p ~/Project/bin
cp ~/dotfiles/termux/bin/x11 ~/Project/bin
chmod +x ~/Project/bin/x11
## 1. run `x11` script
## 2. run `Termux:X11` app

# deno
pacman-key --init
pacman-key --populate
pacman -Syu
pacman -Sy --noconfirm glibc-runner --assume-installed bash,patchelf,resolv-conf
curl -fsSL https://deno.land/install.sh | time sh
export DENO_INSTALL="${HOME}/.deno"
export PATH="${PATH}:${DENO_INSTALL}/bin"
patchelf --print-interpreter --print-needed "$(which deno)"
patchelf --set-rpath "${PREFIX}/glibc/lib" --set-interpreter "${PREFIX}/glibc/lib/ld-linux-aarch64.so.1" "$(which deno)"
ldd "$(which deno)"
cat - << EOF > ~/.deno/bin/deno.glibc.sh
#!/usr/bin/env sh
_oldpwd="\${PWD}"
_dir="\$(dirname "\${0}")"
cd "\${_dir}"
if ! [ -h "deno" ] ; then
  >&2 mv -fv "deno" "deno.orig"
  >&2 ln -sfv "deno.glibc.sh" "deno"
fi
cd "\${_oldpwd}"
LD_PRELOAD= exec "\${_dir}/deno.orig" "\${@}"
# Or
#exec grun "\${_dir}/deno.orig" "\${@}"
EOF
chmod -c u+x ~/.deno/bin/deno.glibc.sh
deno.glibc.sh --version
deno <<< "console.log('Hello world')"
