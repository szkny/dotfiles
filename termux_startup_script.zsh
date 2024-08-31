#!/usr/bin/zsh

termux-setup-storage

pkg update && pkg upgrade
pkg install -y pacman patchelf which time ldd tree
pkg install -y termux-exec
pkg install -y termux-tools
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
pkg install -y ranger w3m lynx

# python
pip3 install setuptools wheel packaging pyproject_metadata cython meson-python versioneer
MATHLIB=m LDFLAGS="-lpython3.11" pip3 install --no-build-isolation --no-cache-dir numpy
LDFLAGS="-lpython3.11" pip3 install --no-build-isolation --no-cache-dir pandas

# cargo
cargo install rm-improved code-minimap git-delta zoxide viu fd-find
cargo install sheldon --locked

