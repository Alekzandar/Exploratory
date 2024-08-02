#!/bin/bash

finished=0

while [ $finished -ne 1 ]
do
	echo "What is your favorite Linux distribution?"
	echo "1 - Arch"
	echo "2 - Debian"
	echo "3 - Mint"
	echo "4 - Ubuntu"
	echo "5 - Misc"
	echo "6 - Exit"
	
	read distro;
	
	case $distro  in
	
		1) echo "Arch is a rolling release.";;
		2) echo "Debian is community distro.";;
		3) echo "Mint is popular on desk and lapts.";;
		4) echo "Ubuntu is popular on both servs and comps.";;
		5) echo "There are many huh...";;
		6) finished=1;;
		*) echo "Not an option!"
	esac
done	
