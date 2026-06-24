

-- 06/24/2026

Change is the end result of all true learning.
– Leo Buscaglia


# Day 62 - Manage Secrets in Kubernetes

The Nautilus DevOps team is working to deploy some tools in Kubernetes cluster. Some of the tools are licence based so that licence information needs to be stored securely within Kubernetes cluster. Therefore, the team wants to utilize Kubernetes secrets to store those secrets. Below you can find more details about the requirements:

We already have a secret key file official.txt under the /opt/ directory. Create a generic secret named official, it should contain the password/license-number present in official.txt file.

Also create a pod named secret-xfusion.

Configure pod's spec as container name should be secret-container-xfusion, image should be debian with latest tag (remember to mention the tag with image). Use sleep command for container so that it remains in running state. Consume the created secret and mount it under /opt/games within the container.

To verify you can exec into the container secret-container-xfusion, to check the secret key under the mounted path /opt/games. Before hitting the Check button please make sure pod/pods are in running state, also validation can take some time to complete so keep patience


```bash
ls /opt
cat /opt/official.txt 
k create secret generic official  --help
k create secret generic official --from-file=/opt/official.txt --dry-run=client -o yaml > q1-secret.yaml
cat q1-secret.yaml 
k create -f q1-secret.yaml 

# pod
k run secret-xfusion --image=debian:latest --dry-run=client -o yaml > q1-pod.yaml
vi q1-pod.yaml 

k explain pod.spec.volumes --recursive
vi q1-pod.yaml 
k create -f q1-pod.yaml 

k get pod
k describe pod secret-xfusion

k exec -it pod/secret-xfusion -c secret-container-xfusion -- bash

k explain pod.spec.volumes.secret --recursive
cat q1-pod.yaml 

k get secret
k describe secret/official

k describe pod secret-xfusion
k exec -it pod/secret-xfusion -c secret-container-xfusion -- bash


```

```text
thor@jump-host ~$ k describe pod secret-xfusion
Name:             secret-xfusion
Namespace:        default
Priority:         0
Service Account:  default
Node:             jump-host/10.244.247.227
Start Time:       Wed, 24 Jun 2026 04:55:45 +0000
Labels:           run=secret-xfusion
Annotations:      <none>
Status:           Running
IP:               10.22.0.9
IPs:
  IP:  10.22.0.9
Containers:
  secret-container-xfusion:
    Container ID:  containerd://ab10a21ddf5cc585821c6f61379871ce0ad5752f4bc1111a1c60fcf37a64ed80
    Image:         debian:latest
    Image ID:      docker.io/library/debian@sha256:1de1fcf32a035452eb3a2c99926a9988509f177b3c99efab609700297d2076bf
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
      -c
      sleep 3600
    State:          Running
      Started:      Wed, 24 Jun 2026 04:55:49 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /opt/games from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-lw69f (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  data:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  official
    Optional:    false
  kube-api-access-lw69f:
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
  Normal  Scheduled  31s   default-scheduler  Successfully assigned default/secret-xfusion to jump-host
  Normal  Pulling    31s   kubelet            Pulling image "debian:latest"
  Normal  Pulled     27s   kubelet            Successfully pulled image "debian:latest" in 3.495s (3.495s including waiting). Image size: 49327660 bytes.
  Normal  Created    27s   kubelet            Created container: secret-container-xfusion
  Normal  Started    27s   kubelet            Started container secret-container-xfusion


thor@jump-host ~$ k get secret
NAME       TYPE     DATA   AGE
official   Opaque   1      23m


thor@jump-host ~$ k exec -it pod/secret-xfusion -c secret-container-xfusion -- bash
root@secret-xfusion:/# ls /opt/games
official.txt
root@secret-xfusion:/# exit

```
