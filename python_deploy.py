#!/usr/bin/env python3

from paramiko import client
import random
import string

#
#Deploy script but actually fucking works and is in python
#Class from daanaerts.com
#
class ssh:
    client = None

    def __init__(self,address,port,username,password):
        print("[*] Connecting to " + address)
        self.client = client.SSHClient()
        self.client.set_missing_host_key_policy(client.AutoAddPolicy())
        self.client.connect(address, port, username=username, password=password, look_for_keys=False)


    def sendCommand(self,command):
        if(self.client):
            stdin, stdout, stderr = self.client.exec_command(command)

            while not stdout.channel.exit_status_ready():
                if stdout.channel.recv_ready():
                    alldata = stdout.channel.recv(1024)

                    while stdout.channel.recv_ready():
                        alldata += stdout.channel.recv(1024)

                    print(str(alldata, "utf8"))
        else:
            print("[-] Error: Connection Not Opened")


#
#Deploying starts here
#

print("[*] Deploy script starting..." )
thefile = input("[*] Enter a file with IP addresses: (hosts.txt) ") or "hosts.txt"

randpass = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(8))


fd = open(thefile,'r')

for line in fd:

    theuser = input("[*] Enter a user to connect to %s: (root) " % line.replace('\n','')) or "root"
    theport = input("[*] Enter the port ssh is listening on: (22) ") or 22
    thepassword = input("[*] Enter the password for %s: (changeme) " % theuser) or "changeme"
    thenewpass = input("[*] Enter a new password for '{0}': ('{1}')".format(line.replace('\n',''),randpass )) or randpass
    connection = ssh(line,int(theport),theuser,thepassword)
    #connection.sendCommand("mkdir testssh;")
    #connection.sendCommand("touch childern")

print("[+] Done")
