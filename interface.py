#!/bin/usr/env python3

import subprocess
import os.path

while true:
    
    userinput = read("[shell]$ ")
    
    if(userinput == "exit"):
	print("[*] Exiting interface... ")

    if(userinput == "deploy"):
	if(os.path.isfile((deploy.py)):
	    print("[*] Running deploy script...")
	
	else:
	    print("[-] Deploy Script not found")
