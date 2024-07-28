#!/bin/bash

package=doesnotexist
sudo apt install $package >> package_install_results.log

if [ $? -eq 0 ]
then
	echo "Installation of $package was successful."
	echo "New command is:"
	which $package
else
	echo "$package failed to install" >> package_install_failure.log
fi
