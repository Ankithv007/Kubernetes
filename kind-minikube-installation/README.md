
# 🧪 Local Kubernetes Setup with Kind and Minikube

This guide helps you install and use two popular local Kubernetes tools:

- [Kind (Kubernetes IN Docker)](https://kind.sigs.k8s.io/)
- [Minikube](https://minikube.sigs.k8s.io/)

---

## ⚙️ Prerequisites

- Docker installed and running
- WSL2 (if on Windows) or native Linux/macOS
- curl and sudo permissions

---

## 🚀 1. Installing `kind` (Kubernetes IN Docker)

### ✅ Step 1: Install Docker

Make sure Docker is running and accessible from your terminal:
```bash
docker version
```

If you're on Windows:
- Install Docker Desktop
- Enable **WSL Integration** for your Linux distro (e.g., Ubuntu)

---

### ✅ Step 2: Install `kind`

#### 📦 For Linux or WSL2
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```


---

### ✅ Step 3: Install `kubectl`
```bash
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

---

### 🚀 Step 4: Create a Kind Cluster

```bash
cat <<EOF > kind-multi-node.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

kind create cluster --config kind-multi-node.yaml

```
```bash
kind create cluster
```

---

### ✅ Step 5: Test the Cluster

```bash
kubectl get nodes
```

You should see:
```
NAME                 STATUS   ROLES           AGE   VERSION
kind-control-plane   Ready    control-plane   Xs    v1.xx.x
```

---

### ❌ Delete Cluster (Optional)

```bash
kind delete cluster
```

---

## 🖥️ 2. Installing Minikube

### ✅ Step 1: Install Docker (same as above)

---

### ✅ Step 2: Install `minikube`

#### 📦 For Linux or WSL2:
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

---

### ✅ Step 3: Start Minikube with Docker

```bash
minikube start --driver=docker
```

It will download and configure a local Kubernetes cluster using Docker.

---

### ✅ Step 4: Test the Cluster

```bash
kubectl get nodes
```

---

### 🛠 Useful Minikube Commands

- Dashboard:
  ```bash
  minikube dashboard
  ```
- LoadBalancer support:
  ```bash
  minikube tunnel
  ```
- Stop cluster:
  ```bash
  minikube stop
  ```
- Delete cluster:
  ```bash
  minikube delete
  ```

---

## 🎯 When to Use What?

| Tool      | Use Case                                |
|-----------|------------------------------------------|
| kind      | CI/CD, fast testing of manifests         |
| minikube  | Full-featured dev clusters with addons   |

---

## 📞 Need Help?

- [Kind Documentation](https://kind.sigs.k8s.io/docs/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
