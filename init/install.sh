#!/usr/bin/env bash

has() {
  type "$1" > /dev/null 2>&1
}
is_wsl() {
  has wslpath
}

#############################################
echo -n "Set install branch name >"
read branchName

echo 'Clone sotalbireo/dotfiles'
if [ -e ~/dotfiles ]; then
  rm -rf ~/dotfiles
fi
git clone -b $branchName https://github.com/sotalbireo/dotfiles.git ~/dotfiles


~/dotfiles/init/setup/link.sh


IS_INSTALL_BREW=true


if [ "$(uname)" == 'Darwin' ]; then
  echo 'The device was detected as macos'
  # install brew
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  source ~/.bash_profile
  ~/dotfiles/init/setup/mac.sh
fi


if is_wsl; then
  echo 'The device was detected as Windows Subsystem on Linux'
  . ~/dotfiles/init/setup/apt.sh

  echo '> Install npiperelay/socat'
  sudo apt-get -y socat
  TMP_DIR=$(mktemp -d)
  cd "$TMP_DIR"
  curl -L https://github.com/jstarks/npiperelay/releases/download/v0.1.0/npiperelay_windows_386.zip -o npiperelay.zip
  unzip -o npiperelay.zip
  sudo cp -f ./npiperelay.exe /usr/local/bin/npiperelay.exe
  cd "$HOME"
  rm -rf "$TMP_DIR"

  if ! has wslvar; then
    echo "> Install wslvar"
    sudo apt-get -y wslu
  else
    echo "> [SKIP] Install wslvar"
  fi

  # homebrew
  if ! has brew; then
    echo "> Install Homebrew"
    /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
  else
    echo "> [SKIP] Install Homebrew"
  fi

  # wslconf
  USERPROFILE="$(wslvar USERPROFILE)"
  if [ -n "$USERPROFILE" ]; then
    WINHOME="$(wslpath :"$USERPROFILE")"
    echo "> \$WINHOME: $WINHOME"
    ln -sL ~/dotfiles/wsl/.wslconfig "$WINHOME"/
    sudo ln -sL ~/dotfiles/wsl/wsl.conf /etc/wsl.conf
  else
    echo "> [ERR] USERPROFILEの値が取得できませんでした"
  fi
else
  echo ""
fi


if "${IS_INSTALL_BREW}"; then
  echo 'Run brew'
  ~/dotfiles/init/setup/brew.sh
fi

# echo 'install tools'
# ~/dotfiles/init/setup/common.sh

echo 'Set symbolic link tools'
~/dotfiles/tools/link.sh

source ~/.bash_profile
