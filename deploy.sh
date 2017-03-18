#!/bin/bash
gitmyshit(){
	git clone https://github.com/landyy/scripts.git
	if [ $? -eq 0 ]; then
		cd scripts
		
		touch errors.txt
		
		echo ""
		echo "Running iptables scripts"
		echo ""	
		if [ -f "iptablesnew.sh"]; then
			./iptablesnew.sh > errors.txt 2>&1
		fi
		
		echo ""
		echo "Running harden script"
		echo ""

		if [ -f "harden.sh"]; then
			./harden.sh > errors.txt 2>&1
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
			echo "Can't find appropriate package manager for except, exiting..."
			exit 1 #gay
		fi
	fi
		
	if [ ! -f $PWD/hosts.txt ]; then
		echo "Please create hosts.txt so where we know where to deploy"
		exit 1
	fi
}

for ip in $(cat hosts.txt); do
    echo "Please enter a password for " $ip "\n"
    read pass
    echo ""

    echo "Please enter a new password for " $ip "\n"
    read pass2
    echo ""
    echo "Write that shit down!"
    echo ""

    #echo "Please enter the ports that you want to allow for this box"
    #TODO
    
    sshpass -p $pass ssh -o StrictHostKeyChecking=no itsec@$ip
    
    echo ""
    echo "Changing Passwords now..."
    echo ""
    echo root:$pass2 | chpasswd
    
    echo ""
    echo "Grabbing scripts"
    echo ""
    
    gitmyshit()

    echo ""
    echo "Look For Errors in errors.txt! Done."
    echo ""

done
