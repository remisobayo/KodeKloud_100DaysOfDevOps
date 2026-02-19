
# Day 52 - Revert Deployment to Previous Version in Kubernetes
- 01/18/2026

Those who hoard gold have riches for a moment.
Those who hoard knowledge and skills have riches for a lifetime.
– The Diary of a CEO

Don't just think, do.
– Horace

Earlier today, the Nautilus DevOps team deployed a new release for an application. However, a customer has reported a bug related to this recent release. Consequently, the team aims to revert to the previous version.

There exists a deployment named nginx-deployment; initiate a rollback to the previous revision.

```bash

kubectl get deployment
kubectl get pods
kubectl describe deployment nginx-deployment
kubectl rollout history deployment/nginx-deployment
kubectl rollout history deployment/nginx-deployment --revision=1
kubectl rollout history deployment/nginx-deployment --revision=2

# See the image used in each revision
kubectl describe replicasets -l app=nginx | grep -A 5 "Image"

# Revert to the immediately previous version
kubectl rollout undo deployment/nginx-deployment
kubectl rollout undo deployment/nginx-deployment --to-revision=1


# 1. Check current state
kubectl rollout history deployment/nginx-deployment

# 2. See what revision has the old version
# REVISION  CHANGE-CAUSE
# 1         kubectl apply --filename=nginx-deployment.yaml --record=true
# 2         kubectl set image deployment nginx-deployment nginx=nginx:1.17

# 3. Revert to revision 1
kubectl rollout undo deployment/nginx-deployment --to-revision=1

# 4. Monitor
kubectl rollout status deployment/nginx-deployment
kubectl get pods


# Another option - updating the yaml file
# 1. Save current configuration (just in case)
kubectl get deployment nginx-deployment -o yaml > nginx-deployment-current.yaml

# 2. Edit your YAML file to use old image
#    Change image: nginx:1.17 → image: nginx:1.16

# 3. Apply the old YAML
kubectl apply -f nginx-deployment-old-version.yaml

```

```text
thor@jumphost ~$ kubectl get deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           93s
```


```text
thor@jumphost ~$ kubectl describe deployment nginx-deployment
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Mon, 19 Jan 2026 05:38:18 +0000
Labels:                 app=nginx-app
                        type=front-end
Annotations:            deployment.kubernetes.io/revision: 2
                        kubernetes.io/change-cause:
                          kubectl set image deployment nginx-deployment nginx-container=nginx:stable --kubeconfig=/root/.kube/config --record=true
Selector:               app=nginx-app
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx-app
  Containers:
   nginx-container:
    Image:         nginx:stable
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
OldReplicaSets:  nginx-deployment-989f57c54 (0/0 replicas created)
NewReplicaSet:   nginx-deployment-665bf769f5 (3/3 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  2m45s  deployment-controller  Scaled up replica set nginx-deployment-989f57c54 to 3
  Normal  ScalingReplicaSet  2m35s  deployment-controller  Scaled up replica set nginx-deployment-665bf769f5 to 1
  Normal  ScalingReplicaSet  2m28s  deployment-controller  Scaled down replica set nginx-deployment-989f57c54 to 2 from 3
  Normal  ScalingReplicaSet  2m28s  deployment-controller  Scaled up replica set nginx-deployment-665bf769f5 to 2 from 1
  Normal  ScalingReplicaSet  2m26s  deployment-controller  Scaled down replica set nginx-deployment-989f57c54 to 1 from 2
  Normal  ScalingReplicaSet  2m26s  deployment-controller  Scaled up replica set nginx-deployment-665bf769f5 to 3 from 2
  Normal  ScalingReplicaSet  2m24s  deployment-controller  Scaled down replica set nginx-deployment-989f57c54 to 0 from 1
  ```

  ```text
  thor@jumphost ~$ kubectl rollout history deployment/nginx-deployment --revision=1
deployment.apps/nginx-deployment with revision #1
Pod Template:
  Labels:       app=nginx-app
        pod-template-hash=989f57c54
  Containers:
   nginx-container:
    Image:      nginx:1.16
    Port:       <none>
    Host Port:  <none>
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
  Node-Selectors:       <none>
  Tolerations:  <none>
```

```text
  thor@jumphost ~$ kubectl rollout history deployment/nginx-deployment --revision=2
deployment.apps/nginx-deployment with revision #2
Pod Template:
  Labels:       app=nginx-app
        pod-template-hash=665bf769f5
  Annotations:  kubernetes.io/change-cause:
          kubectl set image deployment nginx-deployment nginx-container=nginx:stable --kubeconfig=/root/.kube/config --record=true
  Containers:
   nginx-container:
    Image:      nginx:stable
    Port:       <none>
    Host Port:  <none>
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
  Node-Selectors:       <none>
  Tolerations:  <none>
  ```


