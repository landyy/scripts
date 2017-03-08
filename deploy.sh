#!/bin/bash
if [ ! -d /usr/bin/expect ]; then
	echo "expect is needed for this script, installing\n"
	
	if [ -d "/etc/apt/" ]; then
		apt-get install expect
	elif [ -d "/etc/pacman/"]; then
		pacman -S expect
	elif [ -d "/etc/yum" ]; then
		yum install except
	else
		echo "Can't find appropriate package manager for except, exiting...\n"
		exit 1
		

if [ ! -d $PWD/hosts.txt ]; then
	echo "Please create hosts.txt so where we know where to deploy\n"
	exit 1
else
	for ip in $(cat hosts.txt); do
		echo "Please enter a password for " $ip "\n"
		read pass

		expect -c 'spawn ssh root@$ip' "
