

# Day 50 - Set Resource Limits in Kubernetes Pods
- 01/10/2026
One day or day one. It's your choice.

- 01/17/2026
You don’t understand anything until you learn it more than one way.
– Marvin Minsky

The Nautilus DevOps team has noticed performance issues in some Kubernetes-hosted applications due to resource constraints. To address this, they plan to set limits on resource utilization. Here are the details:

Create a pod named httpd-pod with a container named httpd-container. Use the httpd image with the latest tag (specify as httpd:latest). Set the following resource limits:

Requests: Memory: 15Mi, CPU: 100m

Limits: Memory: 20Mi, CPU: 100m

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.


```bash

touch httpd-pod.yaml
sudo vi httpd-pod.yaml
kubectl apply -f httpd-pod.yaml

# verify
kubectl get pod httpd-pod
kubectl describe pod httpd-pod

kubectl delete pod httpd-pod

```


```text
the resource limits are; 
Memory: 15Mi which is Mebibytes (binary MB, 1024² bytes)
CPU units: 100m = 0.1 CPU cores (100 millicores)

resources:
  requests:
    memory: "15Mi"   # ← Guaranteed minimum: 15 Mebibytes RAM
    cpu: "100m"      # ← Guaranteed minimum: 0.1 CPU cores
  limits:
    memory: "20Mi"   # ← Absolute maximum: 20 Mebibytes RAM
    cpu: "100m"      # ← Absolute maximum: 0.1 CPU cores

- requests: The minimum amount of resources that must be guaranteed for the container to run. Kubernetes uses this for scheduling decisions (where to place the pod). The container will get AT LEAST this amount of resources. If a node doesn't have enough resources to meet the requests, Kubernetes won't schedule the pod there

- limits: The maximum amount of resources a container can use. Prevents a container from consuming too many resources and affecting other containers. The container CANNOT use more than this amount of resources.


```