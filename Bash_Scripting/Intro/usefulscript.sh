#!/bin/bash

command=/usr/bin/htop

if [ -f $command ]
then
	echo "$command is available!"
else
	echo "$command is NOT available"
	sudo apt update && sude apt install -y htop
fi

$command
