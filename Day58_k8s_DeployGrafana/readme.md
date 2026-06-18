
-- 06/17/2026
Day 58 - Deploy Grafana on K8s cluster

You don’t learn to walk by following rules. You learn by doing, and falling over.
– Richard Branson


The Nautilus DevOps teams is planning to set up a Grafana tool to collect and analyze analytics from some applications. They are planning to deploy it on Kubernetes cluster. Below you can find more details.

1.) Create a deployment named grafana-deployment-xfusion using any grafana image for Grafana app. Set other parameters as per your choice.
2.) Create NodePort type service with nodePort 32000 to expose the app.

You do not need to make any configuration changes inside the Grafana app once deployed; just make sure you can access the Grafana login page.

Note: The kubectl utility on the jump-host has been configured to work with the Kubernetes cluster.



```bash

k get nodes
cat /etc/*release*

# used the grafana image - grafana/grafana on port 3000
k create deployment grafana-deployment-xfusion --image=grafana/grafana --replicas=1 --help

k create deployment grafana-deployment-xfusion --image=grafana/grafana --replicas=1 --port=3000 --dry-run=client -o yaml > grafana-deployment.yaml

vi grafana-deployment.yaml
k create -f grafana-deployment.yaml 

k get deployment/grafana-deployment-xfusion
k describe deployment/grafana-deployment-xfusion


k expose deployment/grafana-deployment-xfusion --help
k expose deployment/grafana-deployment-xfusion --name=grafana-svc --port=3000 --type=NodePort --target-port=3000 --dry-run=client -o yaml > grafana-svc.yaml

vi grafana-svc.yaml 
k create -f grafana-svc.yaml 
k get service/grafana-svc
k get service/grafana-svc
k describe service/grafana-svc

ls
cat grafana-deployment.yaml
cat grafana-svc.yaml
curl -Lk http://10.22.0.9:3000
k get nodes -o wide

curl -s -o /dev/null -w "%{http_code}\n" http://10.244.240.150:32000
curl -s -o /dev/null -w "%{http_code}\n" http://10.22.0.9:3000
curl -s -o /dev/null -w "%{http_code}\n" -L http://10.22.0.9:3000
curl -s -o /dev/null -w "%{http_code}\n" -L http://10.244.240.150:32000

curl -s -o /dev/null -w "%{http_code}\n" -L http://10.43.208.183:3000



```




```text

kubectl create deployment my-dep --image=busybox:latest --image=ubuntu:latest
--image=nginx








```