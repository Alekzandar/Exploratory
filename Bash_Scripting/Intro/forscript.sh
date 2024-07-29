#!/bin/bash


for file in logfiles/*.log
do
	tar -czvf $file.tar.gz $file
done

for current_number in {1..10}
do
	echo $current_number
	sleep 1
done

echo "This is outside of the foor loop."
