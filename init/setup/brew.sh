#!/usr/bin/env bash

brew install -q asdf
brew install -q bat
brew install -q deno
brew install -q ghq
brew install -q git-delta
brew install -q go-task/tap/go-task
brew install -q htop
brew install -q neofetch
brew install -q peco
brew install -q php
brew install -q tldr
brew install -q yt-dlp

if test "$(uname)" = 'Darwin'; then
brew install -q coreutils
brew install -q gnu-sed
fi
