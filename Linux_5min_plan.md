# Linux 5 Minute Plan

### Scripts
First thing is first, two scripts: iptablesnew.sh and harden.sh

- iptablesnew.sh sets up ip table rules on the mangle table. 
- harden.sh will do some basic auditing (checks sshd_config, vsftpd.conf, etc.)

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
Reset password in one line (helpful at the start)
```
echo "user:password" | chpasswd
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

### Crontab
View cronjobs YOU currently have active
```
crontab -v
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
