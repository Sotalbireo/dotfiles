#!/usr/bin/env bash

has() {
  type "$1" > /dev/null 2>&1
}
is_wsl() {
  has wslpath
}

#############################################
echo 'Clone sotalbireo/dotfiles'
if test -e ~/dotfiles; then
  rm -rf ~/dotfiles
fi
git clone -q https://github.com/sotalbireo/dotfiles.git ~/dotfiles


. ~/dotfiles/init/setup/link.sh


if test "$(uname)" = 'Darwin'; then
  echo 'The device was detected as macos'
  # install brew
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  source ~/.bash_profile
  . ~/dotfiles/init/setup/mac.sh
fi


if is_wsl; then
  echo 'The device was detected as Windows Subsystem on Linux'
  . ~/dotfiles/init/setup/apt.sh
  . ~/dotfiles/init/setup/wsl.sh
else
  echo ""
fi

exec "$SHELL" -l


echo 'Run brew'
. ~/dotfiles/init/setup/brew.sh

echo 'Run asdf'
. ~/dotfiles/init/setup/asdf.sh

# echo 'install tools'
# . ~/dotfiles/init/setup/common.sh

echo 'Set symbolic link tools'
. ~/dotfiles/tools/link.sh


echo "Reboot shell"
exec "$SHELL" -l
