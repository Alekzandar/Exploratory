#!/bin/bash

release_file=/etc/os-release


#-q quiet mode, don't print, grep global editor for regexp and print
if grep -q "Arch" $release_file
then
	#Host based on Arch, run pacman update command
	sudo pacman -Syu
fi

#To make the script work on both Debian or Ubuntu (redundant)
if grep -q "Debian" $release_file || grep -q "Ubuntu" $release_file
then
	sudo apt update
	sudo apt dis-upgrade
fi

