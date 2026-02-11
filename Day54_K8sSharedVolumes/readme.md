

# Day 54 - Kubernetes Shared Volumes
- 02/11/2026
Learning never exhausts the mind.
– Leonardo da Vinci

There are times to stay put, and what you want will come to you, and there are times to go out into the world and find such a thing for yourself.
– Lemony Snicket


We are working on an application that will be deployed on multiple containers within a pod on Kubernetes cluster. There is a requirement to share a volume among the containers to save some temporary data. The Nautilus DevOps team is developing a similar template to replicate the scenario. Below you can find more details about it.

- Create a pod named volume-share-datacenter.
- For the first container, use image ubuntu with latest tag only and remember to mention the tag i.e ubuntu:latest, container should be named as volume-container-datacenter-1, and run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/beta.
- For the second container, use image ubuntu with the latest tag only and remember to mention the tag i.e ubuntu:latest, container should be named as volume-container-datacenter-2, and again run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/apps.
- Volume name should be volume-share of type emptyDir.
- After creating the pod, exec into the first container i.e volume-container-datacenter-1, and just for testing create a file beta.txt with any content under the mounted path of first container i.e /tmp/beta.
- The file beta.txt should be present under the mounted path /tmp/apps on the second container volume-container-datacenter-2 as well, since they are using a shared volume.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.


```bash

kubectl run --help
kubectl run volume-share-devops --image=ubuntu:latest --dry-run=client -o yaml > volume-share-devops-pod.yaml
vi volume-share-devops-pod.yaml
kubectl explain pod.spec --recursive
kubectl explain pod.spec.volumes --recursive
kubectl explain pod.spec.containers --recursive
kubectl apply -f volume-share-datacenter-pod.yaml
kubectl get pods

kubectl exec -it volume-share-devops --container volume-container-devops-1 -- /bin/bash
touch /tmp/blog/blog.txt

kubectl exec -it volume-share-devops --container volume-container-devops-2 -- /bin/bash
cat /tmp/demo/blog.txt

kubectl describe pod/volume-share-devops

```


```text
thor@jumphost ~$ kubectl describe pod/volume-share-devops
Name:             volume-share-devops
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Wed, 11 Feb 2026 19:13:22 +0000
Labels:           run=volume-share-devops
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  volume-container-devops-1:
    Container ID:  containerd://079e7f5baf31d65697e759156e3cb77caa99575c2be4c4998161b4254e696d98
    Image:         ubuntu:latest
    Image ID:      docker.io/library/ubuntu@sha256:cd1dba651b3080c3686ecf4e3c4220f026b521fb76978881737d24f200828b2b
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
    Args:
      infinity
    State:          Running
      Started:      Wed, 11 Feb 2026 19:13:26 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /tmp/blog from volume-share (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-pn7z4 (ro)
  volume-container-devops-2:
    Container ID:  containerd://470f2f29fb793f259c2505c27fd28867c9dd2716cd8cdff8e354a0f39bf15104
    Image:         ubuntu:latest
    Image ID:      docker.io/library/ubuntu@sha256:cd1dba651b3080c3686ecf4e3c4220f026b521fb76978881737d24f200828b2b
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
    Args:
      infinity
    State:          Running
      Started:      Wed, 11 Feb 2026 19:13:26 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /tmp/demo from volume-share (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-pn7z4 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  volume-share:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-pn7z4:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  9m49s  default-scheduler  Successfully assigned default/volume-share-devops to kodekloud-control-plane
  Normal  Pulling    9m48s  kubelet            Pulling image "ubuntu:latest"
  Normal  Pulled     9m45s  kubelet            Successfully pulled image "ubuntu:latest" in 2.745671615s (2.745687482s including waiting)
  Normal  Created    9m45s  kubelet            Created container volume-container-devops-1
  Normal  Started    9m45s  kubelet            Started container volume-container-devops-1
  Normal  Pulling    9m45s  kubelet            Pulling image "ubuntu:latest"
  Normal  Pulled     9m45s  kubelet            Successfully pulled image "ubuntu:latest" in 201.699758ms (201.713964ms including waiting)
  Normal  Created    9m45s  kubelet            Created container volume-container-devops-2
  Normal  Started    9m45s  kubelet            Started container volume-container-devops-2
```