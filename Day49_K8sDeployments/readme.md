
# Day 49 - Deploy Applications with Kubernetes Deployments
-  01/10/2026

The Nautilus DevOps team is delving into Kubernetes for app management. One team member needs to create a deployment following these details:

Create a deployment named nginx to deploy the application nginx using the image nginx:latest (ensure to specify the tag)

Note: The kubectl utility on jump_host is set up to interact with the Kubernetes cluster.


```bash
# apply the yaml file
kubectl apply -f deployment-nginx.yaml

# Check deployment status
kubectl get deployments

# Check pods
kubectl get pods

# Get more details
kubectl describe deployment nginx

# To expose Deployment as a Service
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# Forward local port 8080 to pod's port 80
kubectl port-forward deployment/nginx 8080:80

curl http://localhost:8080
```

```text
For quick testing you can use port forwarding to connect to the pod. The standard way to connect to the pod is to create a K8s - Service.
```


```text
thor@jumphost ~$ kubectl apply -f deployment-nginx.yaml
deployment.apps/nginx created

thor@jumphost ~$ kubectl get deployments
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   1/1     1            1           12s

thor@jumphost ~$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
nginx-57d84f57dc-5w8kg   1/1     Running   0          22s
```

```text
thor@jumphost ~$ kubectl describe deployment nginx
Name:                   nginx
Namespace:              default
CreationTimestamp:      Sat, 10 Jan 2026 17:28:46 +0000
Labels:                 app=nginx
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:         nginx:latest
    Port:          80/TCP
    Host Port:     0/TCP
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-57d84f57dc (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  38s   deployment-controller  Scaled up replica set nginx-57d84f57dc to 1
```