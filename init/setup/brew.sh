#!/usr/bin/env bash

brew install asdf
brew install bat
brew install deno
brew install ghq
brew install git-delta
brew install go-task
brew install htop
brew install neofetch
brew install peco
brew install php
brew install tldr
brew install yt-dlp

if [ "$(uname)" == 'Darwin' ]; then
brew install coreutils
brew install gnu-sed
fi
