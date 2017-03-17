#!/bin/bash
gitmyshit(){
	git clone https://github.com/landyy/scripts.git
	if [ $? -eq 0 ]; then
		cd scripts
		
		echo ""
		echo "Running iptables scripts"
		echo ""	
		if [ -f "iptablesnew.sh"]; then
			#TODO
		fi
		
		echo ""
		echo "Running harden script"
		echo ""

		if [ -f "harden.sh"]; then
			#TODO
		fi

	else
	
		echo "Error cloning. Maybe this box is already pwned :-("

	fi
}

getdeps(){
	if [ ! -f /usr/bin/sshpass ]; then
		echo "expect is needed for this script, installing\n"
	
		if [ -d "/etc/apt/" ]; then
			apt-get install sshpass
		elif [ -d "/etc/pacman/"]; then
			pacman -S sshpass
		elif [ -d "/etc/yum" ]; then
			yum install sshpass
		else
			echo "Can't find appropriate package manager for except, exiting...\n"
			exit 1 #gay
		fi
	fi
		
	if [ ! -f $PWD/hosts.txt ]; then
		echo "Please create hosts.txt so where we know where to deploy"
		exit 1
	fi
}

if [ ! -f /usr/bin/sshpass ]; then
	echo "expect is needed for this script, installing\n"
	
	if [ -d "/etc/apt/" ]; then
		apt-get install sshpass
	elif [ -d "/etc/pacman/"]; then
		pacman -S sshpass
	elif [ -d "/etc/yum" ]; then
		yum install sshpass
	else
		echo "Can't find appropriate package manager for except, exiting...\n"
		exit 1 #gay
	fi
fi		

if [ ! -f $PWD/hosts.txt ]; then
	echo $PWD/hosts.txt
	echo "Please create hosts.txt so where we know where to deploy"
	exit 1
else
	for ip in $(cat hosts.txt); do
		echo "Please enter a password for " $ip "\n"
		read pass

		sshpass -p $pass ssh -o StrictHostKeyChecking=no itsec@$ip

		
	done
fi
