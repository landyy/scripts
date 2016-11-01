#!/bin/bash
#Author: Russell Babarsky


#reset
iptables -F

#Flushes chains
iptables -X

iptables -P OUTPUT ACCEPT
iptables -P INPUT ACCEPT
iptables -P FORWARD DROP

#allows ssh
#iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT

#allows http
#iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT

#allows https
#iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT 



rules(){
	list=(22 80 443)

	for i in ${list[@]} ; do
		iptables -A INPUT -p tcp --dport $i -j ACCEPT
	done	
}

rules

#allow already established connections to have input
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#DNS
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

#allow already established connections to have output 
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A OUTPUT -j DROP
iptables -A INPUT -j DROP
