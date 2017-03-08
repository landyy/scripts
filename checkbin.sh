#!/bin/bash
#
#By: Russell Babarsky
#Checks for modified binaries across the system :)
#

badbin=()

for filename in /bin/* ; do
	if [ "$(/usr/bin/file $filename | grep ASCII)" ]; then
		badbin+=($filename)
	fi
done

if [ ${#badbin[@]} -ne 0 ]; then
	echo ""
	echo "#################################################"
	echo "# Warning: Malicious binaries detected in /bin/ #"
	echo "#################################################"
	echo ""

	for error in "${badbin[@]}"; do
	
		echo "!!" $error "!!"
		echo ""	

	done
fi
		
		
