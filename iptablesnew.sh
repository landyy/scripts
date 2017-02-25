#!/bin/bash
#Author: Russell Babarsky
#Thanks to Micah and Brad


#reset
iptables -t mangle -F
iptables -F

#Flushes chains
iptables -t mangle -X 
iptables -X

iptables -t mangle -P OUTPUT ACCEPT
iptables -t mangle -P INPUT ACCEPT
iptables -t mangle -P FORWARD DROP

#special case for ssh
iptables -t mangle -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

#special case for icmp; Can ping out but can't be pinged
iptables -t mangle -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -t mangle -A OUTPUT -p icmp --icmp-type 8 -j ACCEPT

#output rules
rules_output(){
	output=(80 443)
	
	for j in ${output[@]} ; do
		iptables -t mangle -A OUTPUT -p tcp --sport $j -j ACCEPT
	done
}

#input rules
rules_input(){
	list=(80 443)

	for i in ${list[@]} ; do
		iptables -t mangle -A INPUT -p tcp --dport $i -j ACCEPT
	done	
}

rules_input
rules_output

#allow already established connections to have input
iptables -t mangle -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#loopback
iptables -t mangle -A INPUT -i lo -j ACCEPT
iptables -t mangle -A OUTPUT -o lo -j ACCEPT

iptables -t mangle -A OUTPUT -j DROP
iptables -t mangle -A INPUT -j DROP

#For testing purposes
#sleep 10
#iptables -F
#iptables -F -t mangle
