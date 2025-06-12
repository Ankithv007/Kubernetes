# Kubernetes Networking Guide

This guide explains different ways to access your Kubernetes application and the networking concepts behind them.

## Service Configuration

```yaml
NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
python-web-service   NodePort    10.101.215.217   <none>        8000:30080/TCP   17h
```

## Port Explanation

### Port 8000 (Target Port)
- **What**: The port your application is actually listening on inside the container/pod
- **Why**: This is where your Python web application is running and accepting requests
- **Scope**: Internal to the cluster

### Port 30080 (NodePort)
- **What**: A port automatically assigned by Kubernetes on each cluster node
- **Why**: Allows external access to your service from outside the cluster
- **Scope**: External access point

## IP Addresses

### 192.168.49.2 (Minikube Node IP)
- **What**: The IP address of your minikube cluster node
- **Where**: This is the "external" IP of your single-node minikube cluster
- **Access**: From your host machine (outside minikube)

### 10.101.215.217 (Service ClusterIP)
- **What**: Internal cluster IP assigned to your service
- **Where**: Only accessible from within the Kubernetes cluster
- **Access**: From pods/containers inside the cluster

## Access Methods

| Method | From Where | URL | Purpose |
|--------|------------|-----|---------|
| **Port-forward** | Host machine | `http://localhost:8080/demo` | Development/testing |
| **NodePort** | Host machine | `http://192.168.49.2:30080/demo` | External access |
| **ClusterIP** | Inside cluster | `http://10.101.215.217:8000/demo` | Internal cluster access |
| **DNS** | Inside cluster | `http://python-web-service:8000/demo` | Internal cluster access |

## Traffic Flow Diagrams

### External Access via NodePort
```
Your Browser/curl → 192.168.49.2:30080 → Service (10.101.215.217:8000) → Pod
```

### Internal Access via ClusterIP
```
Inside cluster → ClusterIP (10.101.215.217:8000) → Pod
```

### Port-Forward Access
```
Your Browser/curl (localhost:8080) → kubectl port-forward tunnel → Service (10.101.215.217:8000) → Pod
```

## Commands

### From Host Machine (WSL/Local)
```bash
# Using port-forward (requires kubectl port-forward running)
curl http://localhost:8080/demo

# Using NodePort
curl http://192.168.49.2:30080/demo

# Get minikube IP
minikube ip

# Create port-forward tunnel
kubectl port-forward svc/python-web-service 8080:8000
```

### From Inside Cluster
```bash
# SSH into minikube
minikube ssh

# Using ClusterIP (most direct)
curl http://10.101.215.217:8000/demo

# Using DNS name (best practice)
curl http://python-web-service:8000/demo

# Using NodePort (works but not ideal)
curl http://192.168.49.2:30080/demo
```

## Best Practices

### For Development
- Use `kubectl port-forward` for quick local testing
- Access via `localhost:8080`

### For External Access
- Use NodePort with minikube IP: `192.168.49.2:30080`
- In production, use LoadBalancer or Ingress

### For Internal Cluster Communication
- Use DNS names: `python-web-service:8000`
- Or ClusterIP: `10.101.215.217:8000`

## Ingress Configuration

To use Ingress, update your configuration to match your actual service:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
spec:
  ingressClassName: nginx
  rules:
    - host: hello-world.example
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: python-web-service  # Match your actual service name
                port:
                  number: 8000            # Match your service port
```
## deployment.yml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: python-web-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: python-web-app
  template:
    metadata:
      labels:
        app: python-web-app
    spec:
      containers:
      - name: python-web-app
        image: python-web-app
        imagePullPolicy: Never   # 👈 ADD THIS LINE
        ports:
        - containerPort: 8000
```
## service.yml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: python-web-service
spec:
  type: NodePort
  selector:
    app: python-web-app
  ports:
  - port: 8000
    targetPort: 8000
    nodePort: 30080
```

## Troubleshooting

### Service Not Accessible
1. Check if service exists: `kubectl get svc`
2. Check if pods are running: `kubectl get pods`
3. Verify port configuration: `kubectl describe svc python-web-service`

### Port-Forward Not Working
1. Ensure the service exists and is accessible
2. Check if the port is already in use locally
3. Verify the correct service name and port

### NodePort Not Working
1. Get minikube IP: `minikube ip`
2. Ensure the NodePort is correctly configured
3. Check if minikube is running: `minikube status`