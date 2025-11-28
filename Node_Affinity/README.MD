# Node Affinity Example in Kubernetes

This repository demonstrates how to use **Node Affinity** in Kubernetes by:

- Adding a **label to only one worker node**
- Creating an **NGINX Pod** that must run on that labeled node
- Verifying scheduling
- Removing the label and deleting the pod (cleanup)

This is the simplest practical example for learning Node Affinity.

---

## 📘 1. Identify Nodes

```bash
kubectl get nodes

ip-172-31-2-194      control-plane
ip-172-31-39-222     worker
ip-172-31-6-142      worker

```
### 2. Add Label to ONE Worker Node
```bash
kubectl label node ip-172-31-39-222 app=nginx-node

kubectl get nodes --show-labels

```
- You should see:
- ip-172-31-39-222 → has label app=nginx-node
- Other nodes → no such label

### 3. Create NGINX Pod With Node Affinity
```bash
- nginx-affinity.yaml

apiVersion: v1
kind: Pod
metadata:
  name: nginx-affinity
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: app
            operator: In
            values:
            - nginx-node
  containers:
  - name: nginx
    image: nginx



    - kubectl apply -f nginx-affinity.yaml

```


### 4. Verify Pod Scheduling

```bash 

kubectl get pod nginx-affinity -o wide

NAME             READY   STATUS    NODE
nginx-affinity   1/1     Running   ip-172-31-39-222

```
### 5. Cleanup — Remove Label

```bash
kubectl label node ip-172-31-39-222 app-


- The label should be gone.
kubectl get nodes --show-labels

```
