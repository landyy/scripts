# Linux 5 Minute Plan

### Scripts (If allowed :P)
First thing is first, two scripts: iptablesnew.sh and harden.sh

- iptablesnew.sh sets up ip table rules on the mangle table. 
- harden.sh will do some basic auditing (checks sshd_config, vsftpd.conf, etc.)


###First time on Box

```
/usr/bin/passwd

ps -aux > /lib/proc.txt

netstat -tulpan /lib/con.txt

cp -r /var/www/html /lib/html.bak/

iptables...

systemctl stop <shitty service here>

```

### Logs
"Logs are a good place to go if you need something to do" - knif3

```

/var/logs/syslog <-- Provides information about services

/var/logs/auth.log <-- Provides good information about potential logons

/var/logs/<service> <-- Provides good information about a service

/var/logs/kern.log <-- Provides good info on kernel information (may be useful)

/var/logs/messages <-- Provides good info on basic on system info

```

journalctl is a good tool for systemd

```

journalctl -b <-- journal entries that have been collected since boot

journalctl -u <unit name> <-- journal entires for a specific unit

journalctl _PID=<PID> <-- displays journal entries for specific PID

```


### Basic Commands

Check all processes 
``` 
ps -aux 
```
Check all connections with PID
```
netstat -tulpan
```
Show the exports that have been made
```
declare -f [command]
declare -F
```
Remove a export
```
unset -f [command]
```
Show the users logged on
```
id      #shows logged users
last    #shows last logged
```
Show where something is being run from
```
/proc/[id]
ls -al
#should be a sys link to the file
```
Change password for a user(a must!)
```
passwd
```
Make files immutable (IMPORTANT: ./harden.sh changes name of chattr)
```
chattr +i file      #file is immutable 
chattr -i file      #file is immutable
```
Change permissions on a certain file
```
chmod [u+rwx],[g+rwx],[0+rwx] file
```
```
chmod [700] file        #numbers have a special meaning
```


### Disable Users
To quickly disable users
```
russ:x:500:550:Russell Babarsky:/home/russ:/bin/bash
```
Change that setup in /etc/passwd to
```
russ:!x:500:550:Russell Babarsky:/home/russ:/bin/bash
``` 
Notice the "!" after the x


### IP Tables
Flush



### Crontab
View cronjobs YOU currently have active
```
crontab -e
```
View all cronjobs by all users (must be root)
```
for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l; done
```
Remove all current cron jobs
```
crontab -r
```
Disable cron-jobs (this may break something)
```
echo ALL >>/etc/cron.deny
```


### Escaping from limited Shell
```
python -c 'import pty;pty.spawn("/bin/bash")'
echo os.system('/bin/bash')
/bin/sh -i
:!bash      #vim
```


### Important Linux Directories
```
.bash_history
.bash_rc
/etc/passwd
/etc/shadow
/etc/group
/etc/init.d
/etc/hostname
/etc/network/interfaces
/etc/profile                #system environment variables 
~/.bash_history
/var/log/                   #Linux system logs
/etc/fstab                  #file system mounts
/var/log/apache2/access.log
```

Worth checking binary files and making sure they are still binary
```
file [binary]
```
