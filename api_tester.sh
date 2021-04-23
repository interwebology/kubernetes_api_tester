#!/bin/bash

if [ "$1" != "" ]; then
echo "You wanna search for masters in host file  $1"
else
echo "use: ./api_tester.sh ~/vaquero/site-file/hosts-coreos-nashville-example.yml"
echo "------------------------------------------------------------------------------------------"
echo "This will parse out the masters IPs from a Vaquero yaml file and test each master's IP kube-apiserver process individually " 
echo "If the output gets stuck on one node and times out or another error then jump into that machine and run 'sudo systemctl restart kube-apiserver'"
echo "After you research phase"
echo "------------------------------------------------------------------------------------------"

fi

IP=$(cat $1 | grep master -A10 | grep ipv4|cut -d":" -f2)
while true
    do for ip in $IP
        do
        echo
        date
        echo "working on $ip"
        echo "**Showing just 5 Pods Only**"
        time kubectl get pods --all-namespaces --server=https://$ip:6443 | tail -n 5
    done
    sleep 2s
done
