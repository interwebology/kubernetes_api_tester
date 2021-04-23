#!/bin/bash

if [ "$1" != "" ]; then
echo "You wanna search for masters in host file  $1"
else
echo "use: ./api_tester.sh hosts.txt"
echo "------------------------------------------------------------------------------------------"
echo "This will parse out the masters IPs from a hosts.txt file and test each master's IP kube-apiserver process individually " 
echo "If the output gets stuck on one node and times out or another error then jump into that machine and run 'sudo systemctl restart kube-apiserver'"
echo "After you research phase"
echo "------------------------------------------------------------------------------------------"

fi

IP=$1
while true;do
while IFS= read -r line;
    do for ip in $line
        do
        echo
        date
        echo "working on $ip"
        echo "**Showing just 5 Pods Only**"
        time kubectl get pods --all-namespaces --server=https://$ip:6443 | tail -n 5
    done
    sleep 2s
done<$IP
done
