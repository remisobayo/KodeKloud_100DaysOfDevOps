
# Day 51 - Execute Rolling Updates in Kubernetes
- 01/17/2026
You are exactly where you need to be. You are not behind.

An application currently running on the Kubernetes cluster employs the nginx web server. The Nautilus application development team has introduced some recent changes that need deployment. They've crafted an image nginx:1.17 with the latest updates.

Execute a rolling update for this application, integrating the nginx:1.17 image. The deployment is named nginx-deployment.

Ensure all pods are operational post-update.


```bash
kubectl get pods  # 3 pods are running
kubectl get deployment # 1 deployment named nginx-deployment

kubectl describe deployment nginx-deployment
```

```bash
# Method 1: Using kubectl set image
kubectl set image deployment/nginx-deployment nginx-container=nginx:1.17

# Method 2: Using kubectl edit
kubectl edit deployment nginx-deployment
```

```text
containers:
- name: nginx
  image: nginx:1.16  # Change this to nginx:1.17
```

```bash
# Method 3: Using kubectl patch
kubectl patch deployment nginx-deployment --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"nginx:1.17"}]'
```


```bash
# Watch the rollout status
kubectl rollout status deployment/nginx-deployment

# Check the deployment
kubectl describe deployment nginx-deployment

# Check the pods
kubectl get pods -l app=nginx-app  # or whatever selector your deployment uses

# See the rollout history
kubectl rollout history deployment/nginx-deployment
```


```text
thor@jumphost ~$ kubectl describe deployment nginx-deployment
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Sat, 17 Jan 2026 09:57:01 +0000
Labels:                 app=nginx-app
                        type=front-end
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx-app
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx-app
  Containers:
   nginx-container:
    Image:         nginx:1.16
    Port:          <none>
    Host Port:     <none>
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
NewReplicaSet:   nginx-deployment-989f57c54 (3/3 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  4m35s  deployment-controller  Scaled up replica set nginx-deployment-989f57c54 to 3
```


```text
You can update the image on the nginx-deployment.yaml file which is a safe and recommended approach for managing deployments in production!
```

```bash
# validate rolling update strategy was not changed
kubectl describe deployment nginx-deployment | grep -A 3 Strategy

# check what changed before applying it
kubectl diff -f nginx-deployment.yaml

kubectl apply -f nginx-deployment.yaml
# This will trigger a rolling update automatically.

# verify the update
# Check rollout status
kubectl rollout status deployment/nginx-deployment

# See which image is running
kubectl get pods -l app=nginx -o jsonpath='{.items[*].spec.containers[*].image}'

# Check rollout history (if using --record)
kubectl rollout history deployment/nginx-deployment

```

