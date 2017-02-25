#!/bin/bash

#checking permissions
if [ -d "/var/www/" ]; then
	if [ stat -c "%a" /var/www/html != 700]; then
		echo "Bad Permissions in /var/www/. Fixing..."
		chmod 700 -R /var/www/
	fi
	
fi

#checking default port for ssh
if [ cat /etc/ssh/sshd_config | grep 22 != ""]; then
	echo "Default Port for SSH in use, fixing"
	sed -i 's/Port 22/Port 3434/' /etc/ssh/sshd_config
fi

#checking ftp anon login
if [ -d "/etc/vstpd.conf" ]; then
	if [ cat /etc/vsftpd.conf | grep anonymous_enable=YES ]; then
		sed -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd.conf
	fi
fi

#DNS permissions check
if [ -d "/var/named" ];then
	echo "/var/named exsists"
else
	mkdir /var/named
fi
chmod 770 named

if [ -d "/var/run/named.pid" ];then
	echo "/var/run/named.pid"
else
	touch /var/run/named.pid
fi

chown named:named /var/run/named.pid


#Making certain files immutiable 
chattr +i /etc/passwd
chattr +i /etc/shadow
chattr +i /etc/ssh/sshd_config



