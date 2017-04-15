#!/bin/bash
gitmyshit(){
	git clone https://github.com/landyy/scripts.git
	if [ $? -eq 0 ]; then
		cd scripts
		
		touch errors.txt
		
		echo ""
		echo "Running iptables scripts"
		echo ""	
		if [ -f "iptablesnew.sh" ]; then
			./iptablesnew.sh > errors.txt 2>&1
		else
		    echo ""
		    echo "!!! WARNING: iptablesnew.sh was not run !!!"
		    echo ""
		fi
		
		echo ""
		echo "Running harden script"
		echo ""

		if [ -f "harden.sh" ]; then
			./harden.sh > errors.txt 2>&1
		else
		    echo ""
		    echo "!!! WARNING: harden.sh was not run !!!"
		    echo ""
		fi

	else
		echo ""
		echo "Error cloning. Maybe this box is already pwned :-( Exiting..."
		exit 1

	fi
}

getdeps(){
	if [ ! -f /usr/bin/sshpass ]; then
		echo ""
		echo "sshpass is needed for this script, installing\n"
		echo ""
		
		#TODO add rpm package manager
		if [ -d "/etc/apt/" ]; then
			apt-get install sshpass
		elif [ -d "/etc/pacman/" ]; then
			pacman -S sshpass
		elif [ -d "/etc/yum" ]; then
			yum install sshpass
		else
			echo "We are in a terrible hell. No package managers available :("
			exit 1 #gay
		fi
	fi
		
	if [ ! -f $PWD/hosts.txt ]; then
		echo ""
		echo "Please create hosts.txt so where we know where to deploy"
		echo ""
		exit 1
	fi

	echo ""
	echo "Grabbing LD_Preload Patch"
	echo ""

	curl https://raw.githubusercontent.com/mempodippy/vlany/master/misc/patch_ld.py > patch_ld.py	
}

clear
echo ""
echo "Getting ready to deploy scripts..."

getdeps

for ip in $(cat hosts.txt); do

    echo Please enter a password for  $ip
    read pass
    echo ""

    echo Please enter a NEW password for $ip
    read pass2
    echo ""
    echo "Write that shit down!"
    echo ""

    #echo "Please enter the ports that you want to allow for this box"
    #TODO
    
    passwd | sshpass -p $pass ssh -o StrictHostKeyChecking=no root@$ip
    
    

    echo ""
    echo "Changing Passwords now..."
    echo ""
    echo root:$pass2 | chpasswd
    
    echo ""
    echo "Grabbing scripts"
    echo ""
    
    gitmyshit

    exit

done

echo ""
echo "Look For Errors in errors.txt on each host! Done."
echo ""
