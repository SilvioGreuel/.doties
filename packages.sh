#!/usr/bin/env bash

set -e

as_root=''
[ $UID = 0 ] || as_root='sudo'

info() {
	printf "$(tput bold)$(tput setaf 4) -> $1$(tput sgr0)\n"
}

pacman_packages=(
	# arch
	dkms
	linux-headers

	# programming 
	ctags
	clang
	make
	cmake
	git
	tig
	gcc
	llvm
	emscripten
	dlang-dmd

	#languages
	go
	delve
	ruby
	lua
	perl
	python
	python2
	
	# text editors 
	emacs # search for spacemacs
	vim
	neovim
	python-neovim
	python2-neovim
	code

	# terminal
	alacritty
	kitty
	rxvt-unicode
	tmux
	zsh

	# window managers / desktop 
	xorg-xinit
	i3-gaps
	i3status
	dmenu
	rofi
	nitrogen
	compton

	# virtualization / containerization
	docker
	docker-machine
	docker-compose
	virtualbox
	virtualbox-guest-iso
	virtualbox-host-modules-arch
	qemu
	qemu-arch-extra

	# applications / utils
	htop
	glances
	devtools
	ranger
	mutt
	fzf
	bat
	asciinema
	inetutils
	net-tools
	nmon
	openssh
	pulsemixer
	vlc
	firefox
	the_silver_searcher
	ripgrep
	alsa-utils
	slop
	maim
	exfat-utils
	networkmanager
	aws-cli
	terraform
	dhclient
	tree
	hub
	nmap
	firejail
)

aur_packages=(
	# window managers / utils
	polybar

	# applications / utils
	ngrok
	google-chrome
	barrier
	nvm
)

install_using_pacman() {
	packages=("$@")

	to_install=()
	for pack in "${packages[@]}"; do
		pacman -Qq $pack > /dev/null 2>&1 || to_install+=("$pack")
	done

	if [ "${#to_install}" -gt 0 ]; then
		$as_root pacman -Sy "${to_install[@]}"
	else
		info "Done installing all packages from pacman"
	fi
}

install_using_yay() {
	packages=("$@")

	to_install=()
	for pack in "${packages[@]}"; do
		pacman -Qq $pack > /dev/null 2>&1 || to_install+=("$pack")
	done

	if [ "${#to_install}" -gt 0 ]; then
		yay -Sy "${to_install[@]}"
	else
		info "Done installing all packages from aur"
	fi
}

install_using_pacman "${pacman_packages[@]}"
install_using_yay "${aur_packages[@]}"

