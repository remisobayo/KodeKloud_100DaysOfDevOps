
-- 05/05/2026
For success attitude is equally important as ability.
– Harry F.Bank


# Day 56 - Deploy Nginx Web Server on Kubernetes Cluster 

Some of the Nautilus team developers are developing a static website and they want to deploy it on Kubernetes cluster. They want it to be highly available and scalable. Therefore, based on the requirements, the DevOps team has decided to create a deployment for it with multiple replicas. Below you can find more details about it:

Create a deployment using nginx image with latest tag only and remember to mention the tag i.e nginx:latest. Name it as nginx-deployment. The container should be named as nginx-container, also make sure replica counts are 3.

Create a NodePort type service named nginx-service. The nodePort should be 30011.

Note: The kubectl utility on the jump-host has been configured to work with the Kubernetes cluster.


```bash

kubectl create deployment nginx-deployment --image=nginx:latest --replicas=3 --dry-run=client -o yaml > nginx-dep.yaml
vi nginx-dep.yaml 
cat nginx-dep.yaml 
kubectl apply -f nginx-dep.yaml 
k get deploy

k expose deployment/nginx-deployment --name=nginx-service  --port=80 --dry-run=client -o yaml > nginx-service.yaml
vi nginx-service.yaml 
kubectl apply -f nginx-service.yaml 
kubectl get service/nginx-service

kubectl describe service/nginx-service
curl -L http://10.22.0.11:80
k get nodes -o wide
curl -L http://10.244.164.5:30011


```


```text
thor@jump-host ~$ k get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-864f55c6cf-8xlwl   1/1     Running   0          35s
nginx-deployment-864f55c6cf-g4pkf   1/1     Running   0          31s
nginx-deployment-864f55c6cf-jh5ks   1/1     Running   0          33s
thor@jump-host ~$ kubectl describe service/nginx-service
Name:                     nginx-service
Namespace:                default
Labels:                   app=nginx-deployment
Annotations:              <none>
Selector:                 app=nginx-deployment
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.43.248.73
IPs:                      10.43.248.73
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30011/TCP
Endpoints:                10.22.0.12:80,10.22.0.13:80,10.22.0.14:80
Session Affinity:         None
External Traffic Policy:  Cluster
Internal Traffic Policy:  Cluster



```