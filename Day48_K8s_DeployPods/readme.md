

# Day 48 - Deploy Pods in Kubernetes Cluster
- 01/08/2026

Study hard what interests you the most in the most undisciplined, irreverent and original manner possible.
– Richard P. Feynman


The Nautilus DevOps team is diving into Kubernetes for application management. One team member has a task to create a pod according to the details below:

Create a pod named pod-nginx using the nginx image with the latest tag. Ensure to specify the tag as nginx:latest.

Set the app label to nginx_app, and name the container as nginx-container.

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.

```text
You can create a pod using different methods. Imperative Method - specify the configuration in a command line and execute or Declarative Method - you declare end state in a yaml file and execute kubectl apply command to execute the yaml file.

- Using YAML manifests is the recommended approach for production environments as they can be version-controlled and reviewed
```

```bash
# Method 1
kubectl run pod-nginx \
  --image=nginx:latest \
  --labels=app=nginx_app \
  --restart=Never \
  --port=80

# Note: The --restart=Never flag ensures a Pod is created instead of a Deployment. However, this method doesn't allow setting the container name directly via kubectl run.

# Method 2 - Declarative
# pod-nginx.yaml contains the declarative statement
kubectl apply -f pod-nginx.yaml


# Method 3 - Using kubectl run with overwrite to add container name
# Create the pod first
kubectl run pod-nginx --image=nginx:latest --labels=app=nginx_app --restart=Never --port=80 --dry-run=client -o yaml > pod.yaml

# Edit the pod.yaml to add container name, then apply
kubectl apply -f pod.yaml


# Verify the pod
kubectl get pods pod-nginx --show-labels
kubectl describe pod pod-nginx
```


```text
thor@jumphost ~$ kubectl apply -f pod-nginx.yaml
pod/pod-nginx created


thor@jumphost ~$ kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
pod-nginx   1/1     Running   0          23s


thor@jumphost ~$ kubectl get pods pod-nginx --show-labels
NAME        READY   STATUS    RESTARTS   AGE   LABELS
pod-nginx   1/1     Running   0          75s   app=nginx_app
```

```text
thor@jumphost ~$ kubectl describe pod pod-nginx
Name:             pod-nginx
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Thu, 08 Jan 2026 22:57:27 +0000
Labels:           app=nginx_app
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  nginx-container:
    Container ID:   containerd://7dc8293f72f7cf2e996d4dc4ddba7dc65b2b3d9f10da6ce1cf8fa3fbc0cab60e
    Image:          nginx:latest
    Image ID:       docker.io/library/nginx@sha256:ca871a86d45a3ec6864dc45f014b11fe626145569ef0e74deaffc95a3b15b430
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 08 Jan 2026 22:57:33 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-96jh2 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-96jh2:
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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  102s  default-scheduler  Successfully assigned default/pod-nginx to kodekloud-control-plane
  Normal  Pulling    102s  kubelet            Pulling image "nginx:latest"
  Normal  Pulled     97s   kubelet            Successfully pulled image "nginx:latest" in 5.211855702s (5.211883278s including waiting)
  Normal  Created    96s   kubelet            Created container nginx-container
  Normal  Started    96s   kubelet            Started container nginx-container
```