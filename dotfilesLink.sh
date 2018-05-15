#!/bin/sh

# neovim (0.2.2)
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/nvim/vimrc ~/.config/nvim

# vim (8.0.1283)
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
mkdir -p ~/.vim
ln -sf ~/dotfiles/vim/vimrc ~/.vim

# python syntax checker
mkdir -p ~/.config
ln -sf ~/dotfiles/python_syntax_checker/flake8 ~/.config

# bash
# ln -sf ~/dotfiles/.bashrc ~/.bashrc


