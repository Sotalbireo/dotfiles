#!/usr/bin/env bash

echo '> Install npiperelay/socat'
sudo apt-get -y install socat
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR" || exit
curl -sL -H 'Cache-Control: no-cache,no-store' https://github.com/jstarks/npiperelay/releases/download/v0.1.0/npiperelay_windows_386.zip -o npiperelay.zip
unzip -o npiperelay.zip
sudo cp -f ./npiperelay.exe /usr/local/bin/npiperelay.exe
cd "$HOME" || exit
rm -rf "$TMP_DIR"

if ! has wslvar; then
	echo "> Install wslvar"
	sudo apt-get -y install wslu
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
