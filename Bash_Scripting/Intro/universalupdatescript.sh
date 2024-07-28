#!/bin/bash

if [ -d /etc/pacman.d ]
then
	#Host based on Arch, run pacman update command
	sudo pacman -Syu
fi

if [ -d /etc/apt ]
then
	#Host based on Debian or Ubuntu,
	#Run apt version of command
	sudo apt update
	sudo apt dist-upgrade
fi
