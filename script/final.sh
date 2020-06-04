#!/bin/sh

cd $(pwd)

# echo 'root:'${ROOT_PW} | chpasswd

echo ${SS_JSON} > ss.json

# haskey=false

cat ss.json
# echo 1 > /proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf
sysctl -p

finish(){
	/usr/bin/ssserver -c $(pwd)/ss.json --workers ${WORKER_NUM} -d stop
	exit 0
}

# check_sshkeys(){
# 	for i in `ls -l /etc/ssh|awk '{print $9}'`;
# 	do
# 		if [ "$i" = "ssh_host_rsa_key" ]; then
# 			haskey=true
# 		fi
# 	done;
	
# 	if [ "$haskey" = "false" ]; then
# 		echo "creating keys"
# 		echo -e '\n\n\n' |ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
# 		echo -e '\n\n\n' |ssh-keygen -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key
# 		echo -e '\n\n\n' |ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key
# 	fi
# }

/usr/bin/ssserver -c $(pwd)/ss.json --workers ${WORKER_NUM} -d start
# check_sshkeys
# /usr/sbin/sshd -D

trap finish SIGTERM SIGINT SIGQUIT # action after receive sig

while sleep 3600 & wait $!; do :;done