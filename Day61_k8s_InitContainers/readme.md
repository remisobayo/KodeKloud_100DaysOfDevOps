

-- 06/23/2026
-- Day 61 - Init Containers in Kubernetes

You never know what you can do until you try.
– William Cobbett

Regret for the time wasted can become a power of good in the time that remains.
– Arthur Brisbane

Losers visualize the penalties of failure, Winners visualize the rewards of success.
– Dr.Rob Gilbert


# Question
There are some applications that need to be deployed on Kubernetes cluster and these apps have some pre-requisites where some configurations need to be changed before deploying the app container. Some of these changes cannot be made inside the images so the DevOps team has come up with a solution to use init containers to perform these tasks during deployment. Below is a sample scenario that the team is going to test first.

Create a Deployment named as ic-deploy-devops.

Configure spec as replicas should be 1, labels app should be ic-devops, template's metadata lables app should be the same ic-devops.

The initContainers should be named as ic-msg-devops, use image debian with latest tag and use command '/bin/bash', '-c' and 'echo Init Done - Welcome to xFusionCorp Industries > /ic/blog'. The volume mount should be named as ic-volume-devops and mount path should be /ic.

Main container should be named as ic-main-devops, use image debian with latest tag and use command '/bin/bash', '-c' and 'while true; do cat /ic/blog; sleep 5; done'. The volume mount should be named as ic-volume-devops and mount path should be /ic.

Volume to be named as ic-volume-devops and it should be an emptyDir type.

Note: The kubectl utility on the jump-host has been configured to work with the Kubernetes cluster.


```bash
#k create deployment ic-deploy-datacenter --replicas=1 --labels="app=ic-datacenter" --dry-run=client -o yaml > q1-dep.yaml

k create deployment ic-deploy-devops --replicas=1 --image=debian:latest --image=busybox --dry-run=client -o yaml > q1-dep.yaml

vi q1-dep.yaml
k create -f q1-dep.yaml 

k get deploy
k get pods

# exec into pod and run some commands









```




```text
thor@jump-host ~$ k create deployment ic-deploy-devops --replicas=1 --image=debian:latest --image=busybox --dry-run=client -o yaml > q1-dep.yaml -- 'echo Init Done - Welcome to xFusionCorp Industries > /ic/blog'
error: cannot specify multiple --image options and command


thor@jump-host ~$ k describe deploy ic-deploy-devops 
Name:                   ic-deploy-devops
Namespace:              default
CreationTimestamp:      Tue, 23 Jun 2026 05:32:30 +0000
Labels:                 app=ic-devops
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=ic-devops
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=ic-devops
  Init Containers:
   ic-msg-devops:
    Image:      debian:latest
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/bash
      -c
      echo Init Done - Welcome to xFusionCorp Industries > /ic/blog
    Environment:  <none>
    Mounts:
      /ic from ic-volume-devops (rw)
  Containers:
   ic-main-devops:
    Image:      debian:latest
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/bash
      -c
      while true; do cat /ic/blog; sleep 5; done
    Environment:  <none>
    Mounts:
      /ic from ic-volume-devops (rw)
  Volumes:
   ic-volume-devops:
    Type:          EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:        
    SizeLimit:     <unset>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   ic-deploy-devops-6c546995cc (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  28s   deployment-controller  Scaled up replica set ic-deploy-devops-6c546995cc from 0 to 1




thor@jump-host ~$ k describe pods/ic-deploy-devops-6c546995cc-vs5dr
Name:             ic-deploy-devops-6c546995cc-vs5dr
Namespace:        default
Priority:         0
Service Account:  default
Node:             jump-host/10.244.189.212
Start Time:       Tue, 23 Jun 2026 05:32:30 +0000
Labels:           app=ic-devops
                  pod-template-hash=6c546995cc
Annotations:      <none>
Status:           Running
IP:               10.22.0.9
IPs:
  IP:           10.22.0.9
Controlled By:  ReplicaSet/ic-deploy-devops-6c546995cc
Init Containers:
  ic-msg-devops:
    Container ID:  containerd://a1bb4fde76948f863516ece2fb96a18cad6c7563edbe401f16eef05eab35bd1d
    Image:         debian:latest
    Image ID:      docker.io/library/debian@sha256:fe7312b5f05bf5f43fad76bcd8945642e4e47a68aefd1b73f447615899d0fac1
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/bash
      -c
      echo Init Done - Welcome to xFusionCorp Industries > /ic/blog
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 23 Jun 2026 05:32:34 +0000
      Finished:     Tue, 23 Jun 2026 05:32:34 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /ic from ic-volume-devops (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-k6529 (ro)
Containers:
  ic-main-devops:
    Container ID:  containerd://b14fb18ee72d193214cff36ecc81a366fb7ec222c406943451e77d861c6e595c
    Image:         debian:latest
    Image ID:      docker.io/library/debian@sha256:fe7312b5f05bf5f43fad76bcd8945642e4e47a68aefd1b73f447615899d0fac1
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/bash
      -c
      while true; do cat /ic/blog; sleep 5; done
    State:          Running
      Started:      Tue, 23 Jun 2026 05:32:37 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /ic from ic-volume-devops (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-k6529 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  ic-volume-devops:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-k6529:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  7m7s  default-scheduler  Successfully assigned default/ic-deploy-devops-6c546995cc-vs5dr to jump-host
  Normal  Pulling    7m6s  kubelet            Pulling image "debian:latest"
  Normal  Pulled     7m3s  kubelet            Successfully pulled image "debian:latest" in 3.053s (3.053s including waiting). Image size: 49327526 bytes.
  Normal  Created    7m3s  kubelet            Created container: ic-msg-devops
  Normal  Started    7m3s  kubelet            Started container ic-msg-devops
  Normal  Pulling    7m1s  kubelet            Pulling image "debian:latest"
  Normal  Pulled     7m1s  kubelet            Successfully pulled image "debian:latest" in 416ms (416ms including waiting). Image size: 49327526 bytes.
  Normal  Created    7m1s  kubelet            Created container: ic-main-devops
  Normal  Started    7m    kubelet            Started container ic-main-devops




```
