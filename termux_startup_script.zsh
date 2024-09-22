#!/usr/bin/zsh

termux-setup-storage

pkg update && pkg upgrade
pkg install -y pacman patchelf which time ldd tree
pkg install -y termux-exec
pkg install -y termux-tools
pkg install -y termux-app
pkg install -y libc++
pkg install -y coreutils
pkg install -y openssl
pkg install -y build-essential make cmake ninja
pkg install -y clang
pkg install -y binutils-is-llvm
pkg install -y python libopenblas libandroid-execinfo patchelf
pkg install -y wget
pkg install -y file
pkg install -y golang
pkg install -y nodejs
pkg install -y rust
pkg install -y rustc cargo rustc-nightly
pkg install -y neovim
pkg install -y ranger w3m lynx

# font
pkg install -y lsd
mkdir -p ~/Project/font
cd ~/Project/font
wget https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip
unzip ./HackGen*.zip
cp ./HackGen*/HackGenConsoleNF-Regular.ttf ~/.termux/font.ttf

# for deno
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

# python
pip3 install setuptools wheel packaging pyproject_metadata cython meson-python versioneer
MATHLIB=m LDFLAGS="-lpython3.11" pip3 install --no-build-isolation --no-cache-dir numpy
LDFLAGS="-lpython3.11" pip3 install --no-build-isolation --no-cache-dir pandas
pkg install -y matplotlib

# cargo
cargo install rm-improved code-minimap git-delta zoxide viu fd-find
cargo install sheldon --locked

