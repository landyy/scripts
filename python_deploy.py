#!/usr/bin/env python3

#
#Deploy script but actually fucking works and is in python
#

import subprocess
import sys

hosts = ["192.168.163.129", "192.168.163.129"]

for i in hosts:

	passwd = input("Enter a password for " + i + ": ")	
	
	command="git clone https://github.com/landyy/scripts.git; cd scripts;./iptablesnew;echo root:" + str(passwd) + " | /usr/sbin/chpasswd"
#	print(command)
	ssh = subprocess.Popen(["ssh","%s" % i, command],shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
#im tired. we will do this another time TODO
	result = ssh.stdout.readlines()
#if result == []:
#	error = ssh.stderr.readlines()
#	print >>sys.stderr, "ERROR: %s" % error
#else:
	print(result)
