

-- 05/19/2026
- Day 57: Print Environment Variables

- If you can't explain it simply you don't understand it well enough.
– Albert Einstein


The Nautilus DevOps team is working on to setup some pre-requisites for an application that will send the greetings to different users. There is a sample deployment, that needs to be tested. Below is a scenario which needs to be configured on Kubernetes cluster. Please find below more details about it.

Create a pod named print-envars-greeting.

Configure spec as, the container name should be print-env-container and use bash image.

Create three environment variables:

a. GREETING and its value should be Welcome to

b. COMPANY and its value should be Nautilus

c. GROUP and its value should be Datacenter

Use command ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"'] (please use this exact command), also set its restartPolicy policy to Never to avoid crash loop back.

You can check the output using kubectl logs -f print-envars-greeting command.


Note: The kubectl utility on the jump-host has been configured to work with the Kubernetes cluster.


```bash
kubectl run print-envars-greeting --image=bash --env=GREETING="Welcome to" --env=COMPANY="Nautilus" --env=GROUP=Datacenter  --help


kubectl run print-envars-greeting --image=bash --env=GREETING="Welcome to" --env=COMPANY="Nautilus" --env=GROUP=Datacenter --restart=Never --dry-run=client -o yaml --comma
nd -- "echo" "test" > print-env-pod.yaml

vi print-env-pod.yaml

k create -f print-env-pod.yaml

kubectl logs -f print-envars-greeting

kubectl logs pod/print-envars-greeting

```

