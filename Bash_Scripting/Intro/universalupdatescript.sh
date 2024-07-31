#!/bin/bash

release_file=/etc/os-release
logfile = /var/log/updater.log
errorlog = /var/log/updater_errors.log

#-q quiet mode, don't print, grep global editor for regexp and print
if grep -q "Arch" $release_file
then
	#Host based on Arch, run pacman update command
	sudo pacman -Syu 1>>$logfile 2>>$errorlog
	if [ $? -ne 0 ]
	then
		echo "An error occured, please check $errorlog file."
	fi
fi

#To make the script work on both Debian or Ubuntu (redundant)
if grep -q "Debian" $release_file || grep -q "Ubuntu" $release_file
then
	sudo apt update 1>>$logfile 2>>$errorlog
	if [ $? -ne 0 ]
	then
		echo "An error occured, please check the $errorlog file."
	fi
	sudo apt dis-upgrade -y 1>>$logfile 2>>$errorlog
	if [ $? -ne 0 ]
	then
		echo "An error occured, please the $errorlog file."
	fi
fi

