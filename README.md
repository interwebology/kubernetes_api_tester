# Kubernetes API Tester

This will parse out the kube masters IPs from Vaqureo config and then test each kube-apiserver process individually 

This script tries to return pods because just returning nodes doesn't account for the API's escalation failures which we have seen issues with both in the wild with kube-apiserver. 

Checking pods covers the two different ways I have seen the API fail.


### How to run

***./api_tester.sh ~/vaquero-inventory/sites//site-file/hosts-coreos-denver-example.yml***

If the output gets stuck on one node and then times out then that nodes kube-apiserver process is causing issues. jump into that machine and run 

***'sudo systemctl restart kube-apiserver'***

***Output (Timeout Error Could Vary)***
```>$./api_tester.sh ~/vaquero-inventory/sites//smf-ingest/hosts-coreos-smf.yml
You wanna search for masters in host file  /Users/rwrgh667/vaquero/sites//ingest/hosts-smf.yml
working on 10.144.125.5
**Showing just 5 Pods Only**
smf-dashlp       smf-dashlp-dash-lp-cache-1                           4/4     Running   0          20d
smf-dashlp       smf-dashlp-dash-lp-cache-2                           4/4     Running   0          20d
smf-dashlp       smf-dashlp-dash-lp-cache-3                           4/4     Running   0          20d
smf-dashlp       smf-dashlp-dash-lp-cache-4                           4/4     Running   0          20d
smf-dashlp       tiller-deploy-59dcd9644c-g2qbw                       1/1     Running   0          20d
working on 10.144.125.6
**Showing just 5 Pods Only**
smf-dashlp       smf-dashlp-dash-lp-cache-1                           4/4     Running   0          20d
smf-dashlp       smf-dashlp-dash-lp-cache-2                           4/4     Running   0          20d
smf-dashlp       smf-dashlp-dash-lp-cache-3                           4/4     Running   0          20d
smf-dashlp       smf-dashlp-dash-lp-cache-4                           4/4     Running   0          20d
smf-dashlp       tiller-deploy-59dcd9644c-g2qbw                       1/1     Running   0          20d
working on 10.144.125.7
**Showing just 5 Pods Only**
ERROR: API Timeout
```
 
 
