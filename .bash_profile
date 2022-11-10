if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -e /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  eval "$($(brew --prefix)/bin/brew shellenv)"
fi
