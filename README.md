# Kubernetes
Creating this repo with an intent to make Kubernetes easy for begineers. This is a work-in-progress repo.

## Kubernetes Installation Using KOPS on EC2

### Create an EC2 instance or use your personal laptop.

Dependencies required 

1. Python3
2. AWS CLI
3. kubectl

###  Install dependencies

```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```

```
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
```

```
sudo apt-get update
sudo apt-get install -y python3-pip apt-transport-https kubectl
```

```
pip3 install awscli --upgrade
```

```
export PATH="$PATH:/home/ubuntu/.local/bin/"
```

### Install KOPS (our hero for today)

```
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64

chmod +x kops-linux-amd64

sudo mv kops-linux-amd64 /usr/local/bin/kops
```

### Provide the below permissions to your IAM user. If you are using the admin user, the below permissions are available by default

1. AmazonEC2FullAccess
2. AmazonS3FullAccess
3. IAMFullAccess
4. AmazonVPCFullAccess

### Set up AWS CLI configuration on your EC2 Instance or Laptop.

Run `aws configure`

## Kubernetes Cluster Installation 

Please follow the steps carefully and read each command before executing.

### Create S3 bucket for storing the KOPS objects.

```
aws s3api create-bucket --bucket kops-abhi-storage --region us-east-1
```

### Create the cluster 

```
kops create cluster --name=demok8scluster.k8s.local --state=s3://kops-abhi-storage --zones=us-east-1a --node-count=1 --node-size=t2.micro --master-size=t2.micro  --master-volume-size=8 --node-volume-size=8
```

### Important: Edit the configuration as there are multiple resources created which won't fall into the free tier.

```
kops edit cluster myfirstcluster.k8s.local
```

Step 12: Build the cluster

```
kops update cluster demok8scluster.k8s.local --yes --state=s3://kops-abhi-storage
```

This will take a few minutes to create............

After a few mins, run the below command to verify the cluster installation.

```
kops validate cluster demok8scluster.k8s.local
```
---

# Kubernetes-Zero-to-Hero

This repository is created with the intent of making Kubernetes easy for beginners. It is a work-in-progress and will be updated regularly.

---

## Kubernetes Installation Using KOPS on EC2

### Prerequisites

You can use either:
- An **EC2 instance** (Ubuntu is recommended), or  
- Your **personal laptop** (Linux/macOS preferred)

> ⚠️ Note: If using a laptop, make sure you have an AWS account with sufficient permissions and access to create EC2, S3, IAM, and VPC resources.

---

### Required Dependencies

1. Python3  
2. AWS CLI  
3. `kubectl`  
4. `kops` (Kubernetes Operations tool)

---

### Step 1: Install Dependencies

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```

```bash
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
```

```bash
sudo apt-get update
sudo apt-get install -y python3-pip apt-transport-https kubectl
```

```bash
pip3 install awscli --upgrade
```

```bash
export PATH="$PATH:/home/ubuntu/.local/bin/"
```

---

### Step 2: Install KOPS (Our Hero Today)

```bash
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
```

```bash
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops
```

---

### Step 3: IAM Permissions Required

Ensure your IAM user has the following AWS managed policies:

- `AmazonEC2FullAccess`
- `AmazonS3FullAccess`
- `IAMFullAccess`
- `AmazonVPCFullAccess`

> ✅ If you're using the default **admin/root user**, these permissions are already included.

---

### Step 4: Configure AWS CLI

```bash
aws configure
```

Provide:
- AWS Access Key ID  
- AWS Secret Access Key  
- Default region: `ap-south-1`  
- Output format: `json` or `table`

---

## Create Kubernetes Cluster Using KOPS

Please follow the steps carefully and read each command before running.

---

### Step 5: Create an S3 Bucket (KOPS State Store)

This bucket is used by KOPS to store the cluster configuration.

```bash
aws s3api create-bucket --bucket kops-ankith-storage --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
```

> 📝 You can change the bucket name as per your preference.

---

### Step 6: Create the Kubernetes Cluster

```bash
kops create cluster --name=demok8scluster.k8s.local --state=s3://kops-ankith-storage --zones=ap-south-1a --node-count=1 --node-size=t2.micro --master-size=t2.micro --master-volume-size=8 --node-volume-size=8
```

---

### Step 7: (Optional but Recommended) Edit Cluster Configuration

Some default resources might not be eligible for the free tier. You can edit and customize the cluster configuration before applying.

```bash
kops edit cluster demok8scluster.k8s.local
```

---

### Step 8: Build and Launch the Cluster

```bash
kops update cluster demok8scluster.k8s.local --yes --state=s3://kops-ankith-storage
```

This step will take a few minutes to complete.

---

### Step 9: Validate the Cluster

```bash
kops validate cluster --state=s3://kops-ankith-storage
```

If everything is successful, you should see a message like:  
✅ "Your cluster is ready."

---

## Common Question

**Q: Do I need to create the KOPS setup inside an EC2 VM?**  
**A:** It is **not mandatory** to use an EC2 VM. You can also run the setup on your **local Linux/macOS laptop**, provided you have AWS credentials configured and the required permissions.  
However, using an EC2 VM is helpful for isolation, reproducibility, and practicing in a cloud-native environment.

---

