

-- 06/18/2026
-- Day 59 - Troubleshoot Deployment issues in Kubernetes

The best way to guarantee a loss is to quit.
– Morgan Freeman


#
Last week, the Nautilus DevOps team deployed a redis app on Kubernetes cluster, which was working fine so far. This morning one of the team members was making some changes in this existing setup, but he made some mistakes and the app went down. We need to fix this as soon as possible. Please take a look.

The deployment name is redis-deployment. The pods are not in running state right now, so please look into the issue and fix the same.

Note: The kubectl utility on the jump-host has been configured to work with the Kubernetes cluster.


```bash
k get nodes -o wide
k get deployment
k describe deployment/redis-deployment


k get rs
k get pods -n kube-system
k get configmap

k get pods
k describe pods/redis-deployment-6bc546f779-sd5hq

k get deployment/redis-deployment -o yaml > q1-dep.yaml
vi q1-dep.yaml 
k replace -f q1-dep.yaml --force

k describe deployment/redis-deployment
k get pods
k describe pods/redis-deployment-85cd7f84f5-lg4j6
vi q1-dep.yaml 
k replace -f q1-dep.yaml --force

k describe deployment/redis-deployment
k get pods
k get pods -o wide
k get svc
curl -Lk https://10.43.0.1
curl -Lk https://10.22.0.10:6379

```




```text
The configmap name and the image name was incorrect in the deloyment. The errors can be seen in the events shown in describe pod command. To solve this we need to edit the deployment or replace it.


thor@jump-host ~$ k get deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   0/1     1            0           2m45s
thor@jump-host ~$ k describe deployment/redis-deployment
Name:                   redis-deployment
Namespace:              default
CreationTimestamp:      Fri, 19 Jun 2026 02:05:28 +0000
Labels:                 app=redis
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=redis
Replicas:               1 desired | 1 updated | 1 total | 0 available | 1 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=redis
  Containers:
   redis-container:
    Image:      redis:alpin
    Port:       6379/TCP
    Host Port:  0/TCP
    Requests:
      cpu:        300m
    Environment:  <none>
    Mounts:
      /redis-master from config (rw)
      /redis-master-data from data (rw)
  Volumes:
   data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   config:
    Type:          ConfigMap (a volume populated by a ConfigMap)
    Name:          redis-conig
    Optional:      false
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      False   MinimumReplicasUnavailable
  Progressing    True    ReplicaSetUpdated
OldReplicaSets:  <none>
NewReplicaSet:   redis-deployment-6bc546f779 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  3m8s  deployment-controller  Scaled up replica set redis-deployment-6bc546f779 from 0 to 1


thor@jump-host ~$ k get rs
NAME                          DESIRED   CURRENT   READY   AGE
redis-deployment-6bc546f779   1         1         0       4m19s


thor@jump-host ~$ k get pods -n kube-system
NAME                                      READY   STATUS      RESTARTS   AGE
coredns-7896679cc-txsl5                   1/1     Running     0          48m
helm-install-traefik-crd-pc8td            0/1     Completed   0          48m
helm-install-traefik-t8fcm                0/1     Completed   2          48m
local-path-provisioner-578895bd58-mzmbr   1/1     Running     0          48m
metrics-server-7b9c9c4b9c-st5ph           1/1     Running     0          48m
svclb-traefik-4ef31e82-pcgmd              2/2     Running     0          47m
traefik-6f986b958c-gtvw7                  1/1     Running     0          47m


thor@jump-host ~$ k get configmap
NAME               DATA   AGE
kube-root-ca.crt   1      49m
redis-config       2      5m50s


thor@jump-host ~$ k get pods
NAME                                READY   STATUS              RESTARTS   AGE
redis-deployment-6bc546f779-sd5hq   0/1     ContainerCreating   0          6m14s



thor@jump-host ~$ k get pods
NAME                                READY   STATUS              RESTARTS   AGE
redis-deployment-6bc546f779-sd5hq   0/1     ContainerCreating   0          6m14s


thor@jump-host ~$ k describe pods/redis-deployment-6bc546f779-sd5hq
Name:             redis-deployment-6bc546f779-sd5hq
Namespace:        default
Priority:         0
Service Account:  default
Node:             jump-host/10.244.240.162
Start Time:       Fri, 19 Jun 2026 02:05:28 +0000
Labels:           app=redis
                  pod-template-hash=6bc546f779
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    ReplicaSet/redis-deployment-6bc546f779
Containers:
  redis-container:
    Container ID:   
    Image:          redis:alpin
    Image ID:       
    Port:           6379/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Requests:
      cpu:        300m
    Environment:  <none>
    Mounts:
      /redis-master from config (rw)
      /redis-master-data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jgv5c (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      redis-conig
    Optional:  false
  kube-api-access-jgv5c:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason       Age                   From               Message
  ----     ------       ----                  ----               -------
  Normal   Scheduled    6m34s                 default-scheduler  Successfully assigned default/redis-deployment-6bc546f779-sd5hq to jump-host
  Warning  FailedMount  23s (x11 over 6m35s)  kubelet            MountVolume.SetUp failed for volume "config" : configmap "redis-conig" not found

```