### create one script file and add this there (script.sh)
```

#!/bin/bash
set -euo pipefail

echo "🚀 Starting full installation of Docker, kind, and kubectl..."

# Ensure basic tools
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https

# Install conntrack (required by kube/kind), iproute2 and jq for convenience
sudo apt-get install -y conntrack iproute2 jq

# Kernel modules & sysctl settings commonly required for container networking
echo "🔧 Applying kernel settings for container networking..."
sudo modprobe overlay || true
sudo modprobe br_netfilter || true

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-kind.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system >/dev/null

# -------- Docker --------
if ! command -v docker &>/dev/null; then
  echo "📦 Installing Docker..."
  sudo apt-get install -y docker.io
  sudo systemctl enable --now docker
  echo "✅ Docker installed and started."
else
  echo "✅ Docker already installed: $(docker --version 2>/dev/null || true)"
  sudo systemctl enable --now docker || true
fi

# Add current user to docker group (allows non-sudo docker)
if ! groups "$USER" | grep -q docker; then
  echo "👤 Adding $USER to docker group (you must relogin or run 'newgrp docker')..."
  sudo usermod -aG docker "$USER"
fi

# -------- kind --------
if ! command -v kind &>/dev/null; then
  echo "📦 Installing kind..."
  ARCH=$(uname -m)
  if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "amd64" ]; then
    KINDURL="https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-amd64"
  elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    KINDURL="https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-arm64"
  else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
  fi
  curl -Lo ./kind "$KINDURL"
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind
  echo "✅ kind installed: $(kind --version)"
else
  echo "✅ kind already installed: $(kind --version 2>/dev/null || true)"
fi

# -------- kubectl --------
if ! command -v kubectl &>/dev/null; then
  echo "📦 Installing kubectl (stable)..."
  ARCH=$(uname -m)
  VERSION=$(curl -Ls https://dl.k8s.io/release/stable.txt)
  if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "amd64" ]; then
    curl -Lo ./kubectl "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
  elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    curl -Lo ./kubectl "https://dl.k8s.io/release/${VERSION}/bin/linux/arm64/kubectl"
  else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
  fi
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  echo "✅ kubectl installed: $(kubectl version --client --short)"
else
  echo "✅ kubectl already installed: $(kubectl version --client --short 2>/dev/null || true)"
fi

# -------- Final checks --------
echo
echo "🔍 Verification:"
docker --version || true
kind --version || true
kubectl version --client --short || true

echo
echo "🎉 Installation complete."
echo "Note: If you were added to the 'docker' group you must log out and log back in (or run: newgrp docker) to run docker/kind without sudo."
echo "To create a kind cluster run the kind-create script or use 'kind create cluster --config kind-config.yaml'."


```
### step 2 create yaml kind-config.yaml
```

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4

nodes:
  - role: control-plane
    image: kindest/node:v1.33.1
    extraPortMappings:
      - containerPort: 80      # inside the cluster
        hostPort: 80           # on your machine
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP

  - role: worker
    image: kindest/node:v1.33.1

  - role: worker
    image: kindest/node:v1.33.1

```
- kind create cluster --name=<any name for cluster>  --config=<yaml file name>

- kind create cluster --name=ankith-cluster --config=kind-config.yml

