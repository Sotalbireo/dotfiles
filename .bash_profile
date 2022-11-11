if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if type wslpath > /dev/null 2>&1; then
  eval "$($(brew --prefix)/bin/brew shellenv)"
fi
