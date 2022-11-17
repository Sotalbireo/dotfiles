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

brew tap caskroom/fonts
brew install -q --cask font-cica
brew install -q --cask font-last-resort
brew install -q --cask font-noto-color-emoji
brew install -q --cask font-noto-sans-cjk
brew install -q --cask font-noto-serif-cjk
brew install -q --cask font-sarasa-gothic

if test "$(uname)" = 'Darwin'; then
brew install -q coreutils
brew install -q gnu-sed
fi
