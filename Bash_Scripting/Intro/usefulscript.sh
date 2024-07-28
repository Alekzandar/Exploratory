#!/bin/bash

command=htop

#Brackets invoke test command, expression in brackets invokes test
if command -v $command
then
	echo "$command is available!"
else
	echo "$command is NOT available"
	sudo apt update && sude apt install -y $command
fi

$command
