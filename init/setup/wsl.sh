#!/usr/bin/env bash

if ! has socat; then
  echo '> Install npiperelay/socat'
  sudo apt-get -y -q install socat
  TMP_DIR=$(mktemp -d)
  cd "$TMP_DIR" || exit
  curl -fsSL -H https://github.com/jstarks/npiperelay/releases/download/v0.1.0/npiperelay_windows_386.zip -o npiperelay.zip
  unzip -o npiperelay.zip
  sudo cp -f ./npiperelay.exe /usr/local/bin/npiperelay.exe
  cd "$HOME" || exit
  rm -rf "$TMP_DIR"
else
  echo '> [SKIP] Install npiperelay/socat'
fi

if ! has wslvar; then
  echo "> Install wslvar"
  sudo apt-get -y -q install wslu
else
  echo "> [SKIP] Install wslvar"
fi

# homebrew
if ! has brew; then
  echo "> Install Homebrew"
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
else
  echo "> [SKIP] Install Homebrew"
fi

# wslconf
USERPROFILE="$(wslvar USERPROFILE)"
if test -n "$USERPROFILE"; then
  WINHOME="$(wslpath "$USERPROFILE")"
  echo "> \$WINHOME: $WINHOME"
  cp -f ~/dotfiles/wsl/.wslconfig "$WINHOME"/
  cp -f ~/dotfiles/wsl/.wslgconfig "$WINHOME"/
  sudo cp -f ~/dotfiles/wsl/wsl.conf /etc/wsl.conf
else
  echo "> [ERR] USERPROFILEの値が取得できませんでした"
fi

echo '> Install fonts'
sudo apt-get -y -q install fonts-ipafont fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-ui-extra fonts-open-sans

# git-cola
# note: brewで依存してるqtがmacos依存？
if ! has git-cola; then
  echo '> Install git-cola'
  sudo apt-get -y -q install git-cola
fi
