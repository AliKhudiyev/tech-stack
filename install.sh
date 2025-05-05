#!/bin/zsh

OS=$(uname -s)
installer="brew"
utils="fzf yazi bat zoxide"
term="ghostty"
wm="yabai"
hkd="skhd"
launcher="raycast"

case $OS in
    Linux)
        echo "You are using Linux."
		installer="sudo apt"
		wm="i3"
		hkd="sxkhd"
		launcher=""

		# install utils
		sudo apt install fzf yazi bat zoxide

		# install ghostty terminal
		sudo apt install ghostty

		# install essentials
		sudo apt install vim tmux

		# install & activate hotkey daemon
		/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2025.03.09_all.deb keyring.deb SHA256:2c2601e6053d5c68c2c60bcd088fa9797acec5f285151d46de9c830aaba6173c
		sudo apt install ./keyring.deb
		echo "deb [signed-by=/usr/share/keyrings/sur5r-keyring.gpg] http://debian.sur5r.net/i3/ $(grep '^VERSION_CODENAME=' /etc/os-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
		sudo apt update
		sudo apt install i3

		# install & activate window manager
		sudo apt intall sxhkd
		echo "sxhkd -c $HOME/.config/sxkhd/sxkhdrc" >> ~/.zshrc
        ;;
    Darwin)
        echo "You are using macOS."
		# install utils
		brew install fzf yazi bat zoxide

		# install ghostty terminal
		brew install --cask ghostty

		# install essentials
		brew install vim tmux

		# install & activate window manager
		brew install koekeishiya/formulae/yabai
		yabai --start-service

		# install & activate hotkey daemon
		brew install koekeishiya/formulae/skhd
		skhd --start-service

		# bye-bye spotlight
		brew install --cask raycast
        ;;
    *)
        echo "Unknown operating system: $OS"
        ;;
esac

source ~/.zshrc

# eval "$installer update"
# eval "$installer install $opts $wm"
# eval "$installer install $opts $hkd"
# eval "$installer install $opts $utils"
# eval "$installer install $opts $launcher"
