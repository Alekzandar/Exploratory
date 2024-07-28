#!/bin/bash

myvar=1

while [ -f ./testfile ]
do
	echo "The test file exists."
	sleep 10
done

echo "The file no longer exists as of $(date)."
