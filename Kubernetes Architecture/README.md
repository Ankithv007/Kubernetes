### architecture of Kubernetes (K8s) is designed to efficiently manage containerized applications across multiple nodes in a cluster, ensuring scalability, fault tolerance, and ease of deployment. The architecture is made up of a Control Plane and a Data Plane , each with specific components that work together to orchestrate the entire system
### and this is divivdes into 2 parts
- Control Plane (Master Node)
- Data plane (Worker Nodes)

## 1) Control Plane (Master Node)
- The Control Plane is responsible for managing the overall state of the cluster. It makes decisions about the cluster, such as scheduling, monitoring, and maintaining the desired state of applications.
### 1. API Server:
-  Acts as the front-end for the Kubernetes control plane. It exposes the Kubernetes API, which is used by both internal components (like controllers and schedulers) and external users (like DevOps teams).
- All communication with the cluster happens via the API server.

### 2.etcd:
- A distributed key-value store that stores all cluster state and configuration data. Every piece of cluster data, including pod states, configuration details, secrets, and more, is stored in etcd.
- etcd is the source of truth for the cluster.

### 3.Controller Manager:
- Maages different controllers that monitor the state of the cluster and ensure that the actual state matches the desired state.
- Example controllers include the Replication Controller (ensures the correct number of pods are running), Node Controller (monitors node health), and more.

### 4.Scheduler:
- Responsible for assigning new pods to specific worker nodes based on resource availability and predefined policies. It looks at factors like CPU, memory, and custom requirements, then schedules the pod on the most appropriate node.

### 5.Cloud Controller Manager (Optional):
- If Kubernetes is running in a cloud environment (AWS, GCP, Azure), this component manages interactions between the Kubernetes cluster and cloud services, such as load balancers, storage, and network resources.

## 2) Data Plane (Worker Nodes)
- The Data Plane consists of the worker nodes where the actual containerized applications (pods) run. Each node in the data plane communicates with the control plane to ensure the desired state is maintained.

### 1.Node:
- A worker node can be a physical or virtual machine, and it is responsible for running the pods that are assigned to it by the control plane.
- Each node has its own operating system, container runtime, and the necessary Kubernetes components to run and manage containers.

### 2.Kubelet:
- The kubelet is the agent running on each worker node. It communicates with the control plane and ensures that the containers (pods) on the node are running as expected.
- The kubelet receives instructions from the API server (via the control plane) and enforces the desired state.

### 3.Container Runtime:
- This is the software that is responsible for running containers. Popular container runtimes include Docker, containerd, and CRI-O.
- The container runtime pulls container images, starts and stops containers, and manages their lifecycle.

### 4.Kube-Proxy:
- Kube-proxy runs on each node and handles network communication for pods. It maintains network rules that allow communication within the cluster and enables access to services both internally and externally.
- Kube-proxy also ensures proper load balancing across services.

##  3) Pods:
- The Pod is the smallest and most basic unit in Kubernetes. A pod is a group of one or more containers (usually just one) that share storage, network, and namespace.
- Pods run on worker nodes and are scheduled by the control plane.
- Each pod has its own IP address and can communicate with other pods using services.

images/kubernetes-architecture-diagram-1.png

![Kubernetes Architecture Diagram](./images/kubernetes-architecture-diagram-1.png)



  
