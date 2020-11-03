#!/bin/bash

if [ "$1" != "" ]; then
echo "You wanna search for masters in host file  $1"
else
echo "use: ./api_tester.sh hosts.txt"
echo "------------------------------------------------------------------------------------------"
echo "This will parse out the masters IPs and then test each master IP kube-apiserver process individually " 
echo "This is testing behind the VIP. if you found VIP issues and then try to focus in on ha-proxy service logs" 
echo "If the output gets stuck on one node and then times out then jump into that machine and run 'sudo systemctl restart kube-apiserver'"
echo "Keep in mind a 'get nodes' could pass but 'get pods' could fail on same servers based on escalation failure. Both can be solved with reboot"
echo "the 'get pods' command will catch all failures."
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
