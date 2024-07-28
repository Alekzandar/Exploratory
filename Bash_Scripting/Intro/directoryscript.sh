
#!/bin/bash

directory=/etc


#Be sure to test for failures!
if [ -d $directory ]
then
	echo $? 
	echo "The directory $directory exists."
else 
	echo $?
	echo "The directory $directory doesn't exist."
fi 

echo "The exit code is $?"
