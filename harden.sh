#!/bin/bash

clear

echo "Starting harden.sh..."
echo ""
echo ""
sleep 2

#checking for more accs with UID of 0
uid=$(awk -F: '($3 == 0) {print $1}' /etc/passwd)
root="root"
if [[ $uid != $root ]]; then
	echo ""
	echo "################################################"
	echo "# WARNING: More than one account with UID of 0 #"
	echo "################################################"
	echo ""
	echo "$root"
	echo ""

fi

#checking if users have null passwords
pass=$(awk -F: '($2 == "") {print $1}' /etc/shadow)
if [[ $pass != ""  ]]; then
	echo ""
	echo "################################################"
	echo "# WARNING: Account with null password found    #"
	echo "################################################"
	echo ""
	echo "$pass"
	echo ""
fi


#checking permissions
if [ -d "/var/www/" ]; then
	if [ $(stat -c "%a" /var/www) != 755 ]; then
		echo ""
		echo "########################################"
		echo "# Bad Permissions in /var/www/, fixing #"
		echo "########################################"
		echo ""
		chmod 755 /var/www/
		chmod 644 /var/www/html
	fi

	if [ $(stat -c "%a" /var/www/html) != 644 ]; then
 	
		echo ""
		echo "############################################"
		echo "# Bad Permissions in /var/www/html, fixing #"
		echo "############################################"
		echo ""
		chmod 755 /var/www/
		chmod 644 /var/www/html
	fi
	
fi

#checking default port for ssh
if [ -d "/etc/ssh/" ]; then
	if [ "$(cat /etc/ssh/sshd_config | grep 22)" ]; then
		echo ""
		echo "#######################################"
		echo "# Default Port for SSH in use, fixing #"
		echo "#######################################"
		echo ""
		sed -i 's/Port 22/Port 3434/' /etc/ssh/sshd_config
	fi
fi

#checking ftp anon login
if [ -d "/etc/vstpd.conf" ]; then
	if [ $(cat /etc/vsftpd.conf | grep anonymous_enable=YES) ]; then
		echo ""
		echo "#######################################"
		echo "# Anon login enabled for ftp, fixing  #"
		echo "#######################################"
		echo ""
		sed -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd.conf
	fi
fi

#DNS permissions check
if [ -d "/var/named" ];then
	echo ""
	echo "#######################################"
	echo "# /var/named already exsists          #"
	echo "#######################################"
	echo ""
else
	mkdir /var/named
	chmod 770 named
fi

#check for named.pid
if [ ! -d "/var/run/named.pid" ];then
	touch /var/run/named.pid
fi

#move the chattr command
#mv /usr/bin/chattr /usr/bin/yeezy
#touch chattr
#touch notchattr
#touch nothinghere_:)
#touch notcat
#touch stopit

#Making certain files immutiable 
#yeezy +i /etc/passwd
#yeezy +i /etc/shadow
#yeezy +i /etc/ssh/sshd_config



