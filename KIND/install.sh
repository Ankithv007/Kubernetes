#!/bin/bash
set -euo pipefail

# If running with sudo, use the real user's name for docker-group handling
TARGET_USER="${SUDO_USER:-$USER}"

echo "🚀 Starting full installation of Docker, kind, and kubectl..."
echo "Running as: $(whoami)   target user for docker group: $TARGET_USER"

# Ensure basic tools
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https

# Install conntrack (required by kube/kind), iproute2 and jq for convenience
sudo apt-get install -y conntrack iproute2 jq

# Kernel modules & sysctl settings commonly required for container networking
echo "🔧 Applying kernel settings for container networking..."
sudo modprobe overlay || true
sudo modprobe br_netfilter || true

cat <<'EOF' | sudo tee /etc/sysctl.d/99-kubernetes-kind.conf
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

# Quick docker access check (will fail early if socket permissions are wrong)
echo "🔍 Checking docker access..."
if ! docker info >/dev/null 2>&1; then
  echo "⚠ Docker daemon is running but current user cannot access it."
  echo "  We'll add $TARGET_USER to the docker group so it can access the socket."
fi

# Add target user to docker group (allows non-sudo docker); use SUDO_USER when available
if ! groups "$TARGET_USER" 2>/dev/null | grep -q docker; then
  echo "👤 Adding $TARGET_USER to docker group (you must relogin or run 'newgrp docker')..."
  sudo usermod -aG docker "$TARGET_USER"
fi

# If we still cannot run docker as the effective user, print actionable tip
if ! docker info >/dev/null 2>&1; then
  echo
  echo "❗ Note: Docker socket access still fails in this shell."
  echo "  To continue now without re-login, run:   newgrp docker"
  echo "  Or log out and log back in for group membership to apply."
  echo
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

  TMP_KIND="./kind.tmp.$$"
  curl -fsSL -o "$TMP_KIND" "$KINDURL"
  chmod +x "$TMP_KIND"
  sudo mv "$TMP_KIND" /usr/local/bin/kind
  echo "✅ kind installed: $(/usr/local/bin/kind --version || true)"
else
  echo "✅ kind already installed: $(kind --version 2>/dev/null || true)"
fi

# -------- kubectl --------
if ! command -v kubectl &>/dev/null; then
  echo "📦 Installing kubectl (stable)..."
  ARCH=$(uname -m)
  VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt)
  if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "amd64" ]; then
    KUBECTL_URL="https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
  elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    KUBECTL_URL="https://dl.k8s.io/release/${VERSION}/bin/linux/arm64/kubectl"
  else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
  fi

  TMP_KUBECTL="./kubectl.tmp.$$"
  curl -fsSL -o "$TMP_KUBECTL" "$KUBECTL_URL"
  chmod +x "$TMP_KUBECTL"
  sudo mv "$TMP_KUBECTL" /usr/local/bin/kubectl
  echo "✅ kubectl installed: $(kubectl version --client --short || true)"
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
echo "To create a kind cluster run: kind create cluster --config kind-config.yaml"
