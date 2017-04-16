#!/usr/bin/env python3

from paramiko import client

#
#Deploy script but actually fucking works and is in python
#Class from daanaerts.com
#
class ssh:
    client = None

    def __init__(self,address,username,password):
	print("[*] Connecting to " + address)
	self.client = client.SSHClient()
	self.client.set_missing_host_key_policy(client.AutoAddPolicy())
	self.client.connect(address, username=username, password=password, look_for_key=Flase)
	

    def sendCommand(self,command):
	if(self.client):
	    stdin, stdout, stderr = self.client.exec_command(command)

	    while not stdout.channel.exit_status_ready():
		if stdout.channel.recv_ready():
		    alldata = stdout.channel.recv(1024)

		    while stdout.channel.recv_ready()
			alldata += stdout.channel.recv(1024)
		    
		    print(str(alldata, "utf8")
	else:
	    print("[-] Error: Connection Not Opened")


#
#Deploying starts here
#

print("[*] Deploy script starting..." )


