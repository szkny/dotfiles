#!/bin/sh

# for neovim (0.2.2)
ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/nvim/vimrc ~/.config/nvim/vimrc

# for vim (8.0.1283)
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
mkdir -p ~/.vim
ln -sf ~/dotfiles/vim/vimrc ~/.vim/vimrc
