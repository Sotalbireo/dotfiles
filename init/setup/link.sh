#!/usr/bin/env bash

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
mkdir -p ~/.ssh
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config

if test "$(uname)" = 'Darwin'; then
  ln -sf ~/dotfiles/bash/mac/.bashrc ~/.bashrc
  mkdir -p ~/.1password
  ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.ssh/agent.sock
fi


if is_wsl; then
  ln -sf ~/dotfiles/bash/wsl/.bashrc ~/.bashrc
fi
