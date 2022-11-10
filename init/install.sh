#!/usr/bin/env bash

has() {
  type "$1" > /dev/null 2>&1
}
is_wsl() {
  has wslpath
}

#############################################
echo 'Clone sotalbireo/dotfiles'
if [ -e ~/dotfiles ]; then
  rm -rf ~/dotfiles
fi
git clone https://github.com/sotalbireo/dotfiles.git ~/dotfiles


. ~/dotfiles/init/setup/link.sh


IS_INSTALL_BREW=true


if [ "$(uname)" == 'Darwin' ]; then
  echo 'The device was detected as macos'
  # install brew
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  source "$HOME"/.bash_profile
  . ~/dotfiles/init/setup/mac.sh
fi


if is_wsl; then
  echo 'The device was detected as Windows Subsystem on Linux'
  . ~/dotfiles/init/setup/apt.sh
  . ~/dotfiles/init/setup/wsl.sh
else
  echo ""
fi

source "$HOME"/.bash_profile


if "${IS_INSTALL_BREW}"; then
  echo 'Run brew'
  . ~/dotfiles/init/setup/brew.sh
fi

# echo 'install tools'
# . ~/dotfiles/init/setup/common.sh

echo 'Set symbolic link tools'
. ~/dotfiles/tools/link.sh

source "$HOME"/.bash_profile
