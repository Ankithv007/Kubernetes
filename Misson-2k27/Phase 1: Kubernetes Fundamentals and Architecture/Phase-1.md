# Phase 1: Kubernetes Fundamentals and Architecture

**Priority: Must Know**\
**Target level: DevOps Engineer -- 2 Years Experience**

This README is a complete learning guide for Kubernetes fundamentals and
architecture. The goal is not just to memorize definitions, but to
understand how Kubernetes works, how to implement it, and how to explain
and troubleshoot it in interviews and production environments.

------------------------------------------------------------------------

## Table of Contents

1.  [Kubernetes Basics](#1-kubernetes-basics)
    -   [1.1 What is Kubernetes?](#11-what-is-kubernetes)
    -   [1.2 What is Container
        Orchestration?](#12-what-is-container-orchestration)
    -   [1.3 Why Do We Need Kubernetes?](#13-why-do-we-need-kubernetes)
    -   [1.4 Docker vs Kubernetes](#14-docker-vs-kubernetes)
    -   [1.5 Kubernetes vs Docker Swarm](#15-kubernetes-vs-docker-swarm)
    -   [1.6 Kubernetes Architecture](#16-kubernetes-architecture)
    -   [1.7 What is a Kubernetes
        Cluster?](#17-what-is-a-kubernetes-cluster)
    -   [1.8 Control Plane vs Worker
        Node](#18-control-plane-vs-worker-node)
    -   [1.9 Desired State vs Actual
        State](#19-desired-state-vs-actual-state)
    -   [1.10 Declarative vs Imperative
        Approach](#110-declarative-vs-imperative-approach)
    -   [1.11 What is Kubernetes API?](#111-what-is-kubernetes-api)
    -   [1.12 Kubernetes Objects and
        Resources](#112-kubernetes-objects-and-resources)
    -   [1.13 Self-Healing](#113-what-is-self-healing-in-kubernetes)
    -   [1.14 Horizontal Scaling](#114-horizontal-scaling-in-kubernetes)
    -   [1.15 Rolling Updates and
        Rollbacks](#115-rolling-updates-and-rollbacks)
2.  [Practical Kubernetes
    Commands](#2-practical-kubernetes-commands--must-practice)
3.  [Interview Questions and Answers](#3-interview-questions--phase-1)
4.  [Practical Tasks](#4-practical-tasks--do-these-yourself)
5.  [Final Revision Checklist](#5-phase-1--final-revision-checklist)
6.  [What Comes Next?](#6-what-comes-next)

------------------------------------------------------------------------

# 1. Kubernetes Basics

## 1.1 What is Kubernetes?

**Kubernetes (K8s)** is an open-source container orchestration platform
used to automate the deployment, scaling, management, and networking of
containerized applications.

In simple words, Kubernetes manages containers across multiple servers
(nodes). It makes sure your application is running as expected.

### Example

Suppose you have an application with:

-   React frontend
-   Node.js backend
-   PostgreSQL database

You containerize these applications using Docker.

Now imagine you need to run:

-   3 frontend containers
-   4 backend containers
-   1 database container

Managing all these containers manually becomes difficult.

Kubernetes helps you:

1.  Deploy containers.
2.  Restart failed containers.
3.  Scale applications.
4.  Distribute traffic.
5.  Perform rolling updates.
6.  Roll back failed deployments.
7.  Maintain the desired number of replicas.

### Interview Answer

Kubernetes is an open-source container orchestration platform that
automates container deployment, scaling, networking, and management. It
maintains the desired state of applications using controllers and
continuously monitors the cluster.

------------------------------------------------------------------------

## 1.2 What is Container Orchestration?

Container orchestration means automatically managing containers
throughout their lifecycle.

Consider this scenario:

You have 20 Docker containers running on 5 different servers.

You need to manage:

-   Container deployment
-   Container failures
-   Application scaling
-   Network communication
-   Load balancing
-   Resource allocation
-   Application updates

Doing all this manually is difficult. Container orchestration tools
automate these operations.

### Popular Container Orchestration Tools

  Tool           Description
  -------------- -------------------------------------------
  Kubernetes     Advanced container orchestration platform
  Docker Swarm   Docker's native orchestration solution
  Amazon ECS     AWS container orchestration service
  Nomad          Workload orchestration platform

### Real-Time Example

Suppose your backend normally handles 100 requests per minute. Suddenly,
traffic increases to 10,000 requests per minute.

Container orchestration helps you increase the number of backend
instances to handle the traffic. When traffic decreases, you can scale
down again.

### Interview Answer

Container orchestration is the automated process of deploying, managing,
scaling, networking, and monitoring containers across multiple hosts.

------------------------------------------------------------------------

## 1.3 Why Do We Need Kubernetes?

Let's understand this with a real-world example.

Suppose you deploy an application using Docker on a single EC2 instance.
Initially, everything works perfectly. But production environments
introduce several problems.

### Problems Without Kubernetes

1.  If a container crashes, you need a mechanism to restart it.
2.  If traffic increases, you need to scale containers manually.
3.  If a server fails, your application may become unavailable.
4.  Managing containers across multiple servers becomes difficult.
5.  Deploying new application versions can cause downtime.
6.  Managing service-to-service communication becomes complicated.

### How Kubernetes Solves These Problems

  Problem                Kubernetes solution
  ---------------------- -----------------------------------------
  Container crashes      Self-healing and restart policies
  High traffic           Horizontal scaling
  Server failure         Node health monitoring and rescheduling
  Traffic distribution   Services and load balancing
  Application updates    Rolling updates
  Failed deployments     Rollbacks
  Container networking   Kubernetes networking

### Real-Time Example

Imagine your production application has 3 backend replicas.

One backend Pod crashes. Kubernetes detects that only 2 replicas are
running and the relevant controller works to create another Pod to
maintain the desired count of 3.

You don't need to manually create that replacement Pod.

### Interview Answer

We need Kubernetes to manage containerized applications reliably in
production. It provides self-healing, automated scaling, service
discovery, load balancing, rolling updates, and high availability
capabilities.

------------------------------------------------------------------------

## 1.4 Docker vs Kubernetes

Docker and Kubernetes are not direct replacements for each other.

**Docker** is primarily a platform and ecosystem for building,
packaging, and running containers.

**Kubernetes** is a container orchestration platform that manages
containerized workloads across a cluster.

  -----------------------------------------------------------------------
  Feature                 Docker                  Kubernetes
  ----------------------- ----------------------- -----------------------
  Main purpose            Build and run           Orchestrate
                          containers              containerized workloads

  Container deployment    Yes                     Yes, through a
                                                  container runtime

  Container image         Yes                     No, images are normally
  building                                        built externally

  Scaling                 Manual or external      Manual and automated
                          tools                   options

  Self-healing            Basic restart policies  Pod replacement and
                                                  reconciliation

  Load balancing          Docker networking or    Kubernetes Services
                          other tools             

  Multi-node management   Not its primary role    Yes

  Rolling updates         Not a core standalone   Supported by
                          Docker Engine feature   Deployments

  Service discovery       Docker DNS              Kubernetes DNS
  -----------------------------------------------------------------------

### Example: Docker

``` bash
docker run -d -p 8080:80 nginx
```

This starts an Nginx container.

### Example: Kubernetes

``` bash
kubectl create deployment nginx --image=nginx
```

This creates a Kubernetes Deployment that manages Nginx Pods.

Scale it:

``` bash
kubectl scale deployment nginx --replicas=3
```

Now Kubernetes attempts to maintain 3 replicas.

### Important Interview Point

Kubernetes does not require Docker Engine to run containers.

It uses a Container Runtime Interface (CRI)-compatible runtime such as:

-   containerd
-   CRI-O

Docker images can still be used in Kubernetes because they follow
OCI-compatible image formats.

### Interview Answer

Docker is primarily used to build and run containers, whereas Kubernetes
manages and orchestrates containerized workloads across multiple nodes.

------------------------------------------------------------------------

## 1.5 Kubernetes vs Docker Swarm

Both Kubernetes and Docker Swarm are container orchestration platforms.
However, they differ in capabilities and complexity.

  -----------------------------------------------------------------------
  Feature                 Kubernetes              Docker Swarm
  ----------------------- ----------------------- -----------------------
  Complexity              More complex            Easier to learn

  Installation            More involved           Simple setup

  Scaling                 Extensive options       Supports scaling

  Networking              Advanced networking     Simpler overlay
                          model                   networking

  Load balancing          Services and            Built-in routing mesh
                          Ingress/Gateway         
                          implementations         

  Self-healing            Advanced reconciliation Supports desired-state
                                                  reconciliation

  Ecosystem               Large ecosystem         Smaller ecosystem

  Configuration           YAML manifests          Docker Compose-style
                                                  service definitions

  Production adoption     Very widespread         Less commonly adopted
                                                  for new large
                                                  deployments
  -----------------------------------------------------------------------

### Docker Swarm Example

Initialize Swarm:

``` bash
docker swarm init
```

Create a service:

``` bash
docker service create \
  --name nginx \
  --replicas 3 \
  -p 8080:80 \
  nginx
```

### Kubernetes Example

``` bash
kubectl create deployment nginx --image=nginx
```

``` bash
kubectl scale deployment nginx --replicas=3
```

### Interview Answer

Docker Swarm is simpler to set up and operate, whereas Kubernetes
provides a more extensive orchestration ecosystem, advanced workload
management, and greater flexibility for complex production environments.

------------------------------------------------------------------------

## 1.6 Kubernetes Architecture

**Priority: Very Important -- Must Know**

Kubernetes architecture consists of two major parts:

1.  Control Plane
2.  Worker Nodes

The Control Plane manages the cluster. Worker Nodes run your actual
application workloads.

### A. Control Plane Components

The Control Plane is responsible for managing and maintaining the
Kubernetes cluster.

It contains the following components.

#### 1. kube-apiserver

The API Server is the main entry point to the Kubernetes cluster.

All communication with the Kubernetes cluster happens through the API
Server.

For example, when you execute:

``` bash
kubectl get pods
```

The request flow is:

1.  kubectl sends a request to the API Server.
2.  The API Server authenticates and authorizes the request.
3.  It retrieves the required information from the cluster state.
4.  It returns the result to kubectl.

**Responsibilities:**

-   Accepts API requests.
-   Validates Kubernetes objects.
-   Handles authentication and authorization.
-   Communicates with etcd.
-   Exposes the Kubernetes API.

**Interview Answer:** The kube-apiserver is the front end of the
Kubernetes Control Plane. It exposes the Kubernetes API and handles
requests from kubectl and other components.

#### 2. etcd

etcd is a distributed key-value store that stores Kubernetes cluster
state and configuration data.

Think of etcd as the database of Kubernetes.

It stores information such as:

-   Pod specifications and state
-   Deployment configurations
-   Service configurations
-   ConfigMaps and Secrets
-   Node information
-   Cluster metadata

**Example:**

Suppose you create a Deployment with 3 replicas. The desired
configuration is stored in etcd through the API Server.

**Important:**

-   etcd stores cluster state.
-   It is not your application database.
-   It should be backed up regularly.
-   Losing etcd data without a backup can cause serious cluster recovery
    problems.

**Interview Answer:** etcd is a distributed key-value database used by
Kubernetes to store persistent cluster state and configuration.

#### 3. kube-scheduler

The Scheduler is responsible for deciding which worker node should run a
newly created Pod.

Suppose your cluster has 3 worker nodes:

-   Worker Node 1: 2 CPUs available
-   Worker Node 2: 8 CPUs available
-   Worker Node 3: 4 CPUs available

You create a Pod requiring 4 CPUs.

The Scheduler evaluates eligible nodes based on resource requirements,
scheduling constraints, affinity, taints and tolerations, and other
scheduling policies. It selects a suitable node.

**Important:** The Scheduler selects the node. It does not directly
start the container.

**Interview Answer:** kube-scheduler watches for unscheduled Pods and
assigns them to suitable worker nodes based on resource availability and
scheduling rules.

#### 4. kube-controller-manager

The Controller Manager runs various controllers that continuously
monitor cluster resources and reconcile actual state with desired state.

**Example:**

You create a Deployment with:

``` yaml
replicas: 3
```

Only 2 Pods are running because one Pod failed. The relevant controllers
detect the difference and work to restore the desired count of 3.

Some important controllers:

-   Node Controller
-   Deployment and ReplicaSet controllers
-   Job Controller
-   EndpointSlice Controller
-   Namespace Controller

**Interview Answer:** kube-controller-manager runs controllers that
continuously monitor the cluster and ensure resources match their
desired state.

#### 5. cloud-controller-manager

This component integrates Kubernetes with cloud provider infrastructure.

For example, when running Kubernetes on AWS, it can coordinate with AWS
infrastructure.

Responsibilities can include:

-   Managing cloud load balancers
-   Managing node-related cloud information
-   Integrating routes with supported cloud networking

**Interview Answer:** cloud-controller-manager allows Kubernetes to
interact with cloud provider APIs and manage cloud-specific resources.

### B. Worker Node Components

Worker Nodes are the machines where your application workloads run.

Each worker node generally contains these components.

#### 1. kubelet

kubelet is an agent that runs on every worker node.

Its responsibility is to ensure that the Pods assigned to that node are
running as specified.

**Example:**

The Scheduler assigns a Pod to Worker Node 1.

The kubelet on Worker Node 1:

1.  Receives the Pod specification through the Kubernetes control-plane
    communication path.
2.  Requests the container runtime to create containers.
3.  Monitors the Pod.
4.  Reports node and Pod status to the API Server.

**Interview Answer:** kubelet is an agent running on each worker node
that ensures assigned Pods and their containers are running according to
their specifications.

#### 2. kube-proxy

kube-proxy runs on worker nodes and implements Service networking
behavior.

It helps route traffic to the appropriate backend Pods using networking
rules.

Depending on the cluster configuration, it uses mechanisms such as:

-   iptables
-   IPVS

Some Kubernetes networking implementations can replace kube-proxy
functionality entirely.

**Example:**

Your backend application has 3 Pods. A Kubernetes Service provides a
stable IP and DNS name to access those Pods. kube-proxy helps implement
the traffic-forwarding rules for that Service.

**Interview Answer:** kube-proxy implements Kubernetes Service
networking by maintaining network rules that enable traffic forwarding
to backend Pods.

#### 3. Container Runtime

The container runtime is responsible for running containers.

Examples:

-   containerd
-   CRI-O

It handles:

-   Pulling container images
-   Creating containers
-   Starting containers
-   Stopping containers
-   Managing container lifecycle

**Interview Answer:** The container runtime executes containers on
worker nodes and communicates with kubelet through the Container Runtime
Interface (CRI).

### Complete Kubernetes Request Flow

Let's understand what happens when you deploy an application.

You execute:

``` bash
kubectl apply -f deployment.yaml
```

The flow:

1.  kubectl sends the request to kube-apiserver.
2.  API Server authenticates, authorizes, and validates the request.
3.  The desired resource state is persisted in etcd.
4.  Deployment Controller creates or updates a ReplicaSet.
5.  ReplicaSet Controller creates the required Pods.
6.  Scheduler selects suitable worker nodes for unscheduled Pods.
7.  kubelet on the selected nodes observes the assigned Pod
    specifications.
8.  Container runtime pulls the image if necessary.
9.  Container runtime starts the containers.
10. Pod and node status are reported back through the API Server.

**Remember this flow for interviews.**

------------------------------------------------------------------------

## 1.7 What is a Kubernetes Cluster?

A Kubernetes Cluster is a group of machines working together to run
containerized applications.

It consists of:

-   Control Plane nodes
-   Worker Nodes

### Example

  Machine         Role
  --------------- --------------------
  Master Node 1   Control Plane
  Worker Node 1   Runs frontend Pods
  Worker Node 2   Runs backend Pods
  Worker Node 3   Runs database Pods

Together, these machines form one Kubernetes cluster.

### Example Using Minikube

You can create a local Kubernetes cluster using:

``` bash
minikube start
```

Check cluster information:

``` bash
kubectl cluster-info
```

Check nodes:

``` bash
kubectl get nodes
```

Check nodes with additional details:

``` bash
kubectl get nodes -o wide
```

**Important Interview Point:** A Kubernetes cluster can have one or
multiple Control Plane nodes and one or multiple Worker Nodes.
Production environments commonly use multiple Control Plane nodes for
high availability.

------------------------------------------------------------------------

## 1.8 Control Plane vs Worker Node

This is an important interview question.

  Feature               Control Plane                          Worker Node
  --------------------- -------------------------------------- -------------------
  Main responsibility   Manages cluster                        Runs applications
  API Server            Yes                                    No
  etcd                  Usually                                No
  Scheduler             Yes                                    No
  Controller Manager    Yes                                    No
  kubelet               Usually                                Yes
  kube-proxy            Not normally                           Usually
  Container Runtime     May be installed                       Yes
  Application Pods      Possible, depending on configuration   Yes

### Simple Example

Think about a company:

-   Control Plane = Manager
-   Worker Nodes = Employees
-   Pods = Tasks being performed

The manager decides what needs to be done, while employees perform the
actual work.

### Interview Answer

The Control Plane manages the Kubernetes cluster, schedules workloads,
and maintains the desired state. Worker Nodes execute application
workloads inside Pods.

### Practical Commands

``` bash
kubectl get nodes
```

``` bash
kubectl describe node <node-name>
```

------------------------------------------------------------------------

## 1.9 Desired State vs Actual State

**Priority: Extremely Important**

This is one of the most fundamental Kubernetes concepts.

**Desired State:** What you want Kubernetes to maintain.

**Actual State:** What is currently happening in the cluster.

### Example

You create a Deployment:

``` yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```

Here:

``` yaml
replicas: 3
```

This means you want 3 Pods.

-   Desired state = 3 Pods
-   Actual state = 3 Pods

Everything is correct.

Now imagine one Pod crashes.

Your actual state becomes 2 Pods, but your desired state is still 3
Pods.

Kubernetes detects the difference and creates another Pod.

### What is Reconciliation?

Reconciliation is the continuous process of comparing the desired state
with the actual state and taking action to make them match.

### Interview Answer

Desired state represents what we want the cluster to maintain, while
actual state represents its current condition. Kubernetes controllers
continuously reconcile both states to ensure that the cluster matches
the desired configuration.

------------------------------------------------------------------------

## 1.10 Declarative vs Imperative Approach

Kubernetes supports two major ways of managing resources.

### A. Imperative Approach

In the imperative approach, you tell Kubernetes exactly what action to
perform using commands.

Create a Deployment:

``` bash
kubectl create deployment nginx --image=nginx
```

Scale Deployment:

``` bash
kubectl scale deployment nginx --replicas=3
```

Delete Deployment:

``` bash
kubectl delete deployment nginx
```

You directly execute commands to perform operations.

### B. Declarative Approach

In the declarative approach, you define the desired configuration in a
YAML file.

Create `deployment.yaml`:

``` yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```

Apply configuration:

``` bash
kubectl apply -f deployment.yaml
```

Kubernetes continuously works to maintain the declared configuration.

### Comparison

  -----------------------------------------------------------------------
  Feature                 Imperative              Declarative
  ----------------------- ----------------------- -----------------------
  Method                  Commands                YAML manifests

  Approach                Tell what to do         Define desired state

  Reusability             Less convenient         High

  Version control         More difficult          Easy with Git

  Automation              Possible                Very suitable

  Production usage        Useful for specific     Commonly preferred
                          operations              
  -----------------------------------------------------------------------

### Which Approach Is Preferred in Production?

The declarative approach is commonly preferred because you can:

-   Store YAML files in GitHub.
-   Review changes.
-   Use GitOps.
-   Maintain configuration.
-   Recreate environments.
-   Automate deployments.

### Important Commands

``` bash
kubectl apply -f deployment.yaml
```

``` bash
kubectl delete -f deployment.yaml
```

``` bash
kubectl diff -f deployment.yaml
```

------------------------------------------------------------------------

## 1.11 What is Kubernetes API?

Kubernetes API is the interface through which users and Kubernetes
components interact with the cluster.

The API Server exposes Kubernetes resources and operations through REST
APIs.

For example, when you run:

``` bash
kubectl get pods
```

kubectl communicates with the Kubernetes API Server to retrieve Pod
information.

When you run:

``` bash
kubectl create deployment nginx --image=nginx
```

kubectl sends a request to the API Server to create a Deployment.

### Important API Concepts

#### API Group

Kubernetes resources are organized into API groups.

  API Group                Resources
  ------------------------ ------------------------------------------------
  Core API (`v1`)          Pod, Service, ConfigMap, Secret
  `apps/v1`                Deployment, ReplicaSet, StatefulSet, DaemonSet
  `batch/v1`               Job, CronJob
  `networking.k8s.io/v1`   Ingress, NetworkPolicy

#### API Version

Specifies the version of the API used for a resource.

Example:

``` yaml
apiVersion: apps/v1
```

#### Kind

Defines the type of Kubernetes object.

Example:

``` yaml
kind: Deployment
```

#### Metadata

Contains identifying information.

Example:

``` yaml
metadata:
  name: nginx
  namespace: default
  labels:
    app: nginx
```

#### Spec

Defines the desired configuration.

#### Status

Contains the observed state of the resource.

### How to Explore Kubernetes APIs

List API resources:

``` bash
kubectl api-resources
```

List API versions:

``` bash
kubectl api-versions
```

Get Deployment documentation:

``` bash
kubectl explain deployment
```

Get detailed Pod documentation:

``` bash
kubectl explain pod.spec
```

### Interview Answer

The Kubernetes API provides a REST interface for managing cluster
resources. The API Server receives and processes requests, allowing
users and internal components to interact with Kubernetes objects.

------------------------------------------------------------------------

## 1.12 Kubernetes Objects and Resources

First, understand the difference.

**Kubernetes Object:** An object is a persistent record representing the
desired state of something in your cluster.

**Kubernetes Resource:** A resource is an API-defined type that
represents an object or capability managed by Kubernetes.

For example:

-   Deployment is a resource type.
-   A particular Deployment named `nginx` is an object of that type.

### Important Kubernetes Resources

  Resource                Purpose
  ----------------------- -------------------------------------------
  Pod                     Runs one or more containers
  Deployment              Manages stateless application replicas
  ReplicaSet              Maintains the desired number of Pods
  StatefulSet             Manages stateful applications
  DaemonSet               Runs a Pod on each eligible node
  Service                 Provides stable network access to Pods
  ConfigMap               Stores non-sensitive configuration
  Secret                  Stores sensitive configuration data
  Namespace               Provides logical resource isolation
  Job                     Runs a task to completion
  CronJob                 Runs scheduled tasks
  Ingress                 Manages HTTP/HTTPS routing into a cluster
  PersistentVolume        Represents storage resources
  PersistentVolumeClaim   Requests storage
  NetworkPolicy           Controls Pod network traffic

### Example: Kubernetes Object YAML

``` yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx-pod

spec:
  containers:
    - name: nginx
      image: nginx:latest
```

The important fields are:

-   `apiVersion`: API version
-   `kind`: Resource type
-   `metadata`: Object identity and labels
-   `spec`: Desired configuration
-   `status`: Observed state, maintained by Kubernetes

### Practical Commands

``` bash
kubectl get pods
```

``` bash
kubectl get deployments
```

``` bash
kubectl get services
```

``` bash
kubectl get all
```

**Remember:** `kubectl get all` does not actually list every resource
type in Kubernetes.

------------------------------------------------------------------------

## 1.13 What is Self-Healing in Kubernetes?

Self-healing is Kubernetes' ability to automatically recover from
certain application and infrastructure failures.

Suppose your application has 3 Pods.

One Pod crashes. Kubernetes detects the failure and the relevant
controllers work to maintain 3 replicas.

### How Kubernetes Provides Self-Healing

#### 1. Container Restart

If a container exits, kubelet works with the Pod's restart policy to
restart it when appropriate.

#### 2. Pod Replacement

If a Pod managed by a Deployment is deleted or fails, its controller
creates a replacement Pod.

#### 3. Node Failure Handling

If a node becomes unhealthy, Kubernetes can mark it NotReady and,
depending on conditions and configuration, reschedule replacement Pods
elsewhere.

#### 4. Health Probes

Kubernetes supports three important probes.

  Probe       Purpose
  ----------- ------------------------------------------------------
  Liveness    Checks whether the container should be restarted
  Readiness   Checks whether the Pod is ready to receive traffic
  Startup     Checks whether the application has finished starting

### Example Probe Configuration

``` yaml
livenessProbe:
  httpGet:
    path: /health
    port: 3000
  initialDelaySeconds: 10
  periodSeconds: 5

readinessProbe:
  httpGet:
    path: /health
    port: 3000
  initialDelaySeconds: 5
  periodSeconds: 5
```

**Important Interview Question: What is the difference between liveness
and readiness?**

-   Liveness: Should Kubernetes restart the container?
-   Readiness: Should the Pod receive traffic?

A failed readiness probe does not automatically restart the container.

### Interview Answer

Kubernetes provides self-healing through controllers, restart policies,
health probes, and node monitoring. It detects failures and takes
corrective action to maintain the desired application state.

------------------------------------------------------------------------

## 1.14 Horizontal Scaling in Kubernetes

Horizontal scaling means increasing or decreasing the number of
application instances (Pods).

Suppose your application normally runs with 2 backend Pods.

When traffic increases, you want 5 Pods. When traffic decreases, you
want 2 Pods again.

This is horizontal scaling.

There are two common ways to scale.

### A. Manual Scaling

You can manually increase the number of replicas.

``` bash
kubectl scale deployment nginx --replicas=5
```

Check Pods:

``` bash
kubectl get pods
```

Now Kubernetes attempts to maintain 5 replicas.

### B. Automatic Scaling -- HPA

HPA stands for **Horizontal Pod Autoscaler**.

It automatically adjusts the number of Pod replicas based on observed
metrics.

For example:

1.  CPU usage increases.
2.  HPA detects the increase.
3.  HPA increases the number of replicas.
4.  When CPU usage decreases, HPA can scale down.

Example:

``` bash
kubectl autoscale deployment nginx \
  --cpu-percent=50 \
  --min=2 \
  --max=10
```

This creates an HPA with:

-   Minimum replicas: 2
-   Maximum replicas: 10
-   Target average CPU utilization: 50%

Check HPA:

``` bash
kubectl get hpa
```

Describe HPA:

``` bash
kubectl describe hpa nginx
```

**Important:** CPU-based HPA requires resource requests to be configured
for the relevant containers and a working metrics pipeline, commonly
Metrics Server.

### Types of Kubernetes Scaling

  -----------------------------------------------------------------------
  Type                                Meaning
  ----------------------------------- -----------------------------------
  Horizontal Pod Autoscaler (HPA)     Increases/decreases Pod replicas

  Vertical Pod Autoscaler (VPA)       Adjusts container resource requests

  Cluster Autoscaler                  Adds/removes cluster nodes when
                                      supported and configured
  -----------------------------------------------------------------------

### Interview Answer

Horizontal scaling increases or decreases the number of Pod replicas
according to application demand. Kubernetes supports manual scaling and
automatic scaling using HPA.

------------------------------------------------------------------------

## 1.15 Rolling Updates and Rollbacks

**Priority: Very Important -- Production Concept**

Let's say your application is running with:

``` text
nginx:1.25
```

Now developers release:

``` text
nginx:1.26
```

You need to deploy the new version without taking down the entire
application.

This is where rolling updates are useful.

### A. Rolling Updates

A rolling update gradually replaces old Pods with new Pods.

Suppose you have 4 replicas.

Initially:

``` text
Pod 1 -> nginx:1.25
Pod 2 -> nginx:1.25
Pod 3 -> nginx:1.25
Pod 4 -> nginx:1.25
```

During deployment:

``` text
Pod 1 -> nginx:1.26
Pod 2 -> nginx:1.26
Pod 3 -> nginx:1.25
Pod 4 -> nginx:1.25
```

After deployment:

``` text
Pod 1 -> nginx:1.26
Pod 2 -> nginx:1.26
Pod 3 -> nginx:1.26
Pod 4 -> nginx:1.26
```

### How to Perform a Rolling Update

``` bash
kubectl set image deployment/nginx nginx=nginx:1.26
```

Check rollout status:

``` bash
kubectl rollout status deployment/nginx
```

Check rollout history:

``` bash
kubectl rollout history deployment/nginx
```

### B. Rollback

Suppose you deployed version 1.26, but it has a bug and your application
is not working correctly.

You want to return to the previous working version.

This is called rollback.

Command:

``` bash
kubectl rollout undo deployment/nginx
```

Check deployment:

``` bash
kubectl get pods
```

Check rollout history:

``` bash
kubectl rollout history deployment/nginx
```

You can also roll back to a particular revision:

``` bash
kubectl rollout undo deployment/nginx --to-revision=2
```

### Important Rolling Update Configuration

In a Deployment, you can configure:

``` yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 0
```

**What do these values mean?**

-   `maxSurge: 1` -- Kubernetes can create one extra Pod above the
    desired replica count during the update.
-   `maxUnavailable: 0` -- Kubernetes should not intentionally make any
    of the desired replicas unavailable during the update.

These settings can help maintain availability, assuming sufficient
resources and healthy new Pods.

### Interview Answer

Rolling updates allow Kubernetes to gradually replace old application
Pods with new versions without requiring a complete application
shutdown. If the new deployment causes issues, we can use
`kubectl rollout undo` to roll back to a previous revision.

------------------------------------------------------------------------

# 2. Practical Kubernetes Commands -- Must Practice

These are the commands you should be comfortable using as a DevOps
Engineer.

  Command                             Purpose
  ----------------------------------- -------------------------------------
  `kubectl version`                   Check Kubernetes version
  `kubectl cluster-info`              Get cluster information
  `kubectl get nodes`                 List cluster nodes
  `kubectl get pods`                  List Pods
  `kubectl get pods -o wide`          Show Pod details and node placement
  `kubectl get deployments`           List Deployments
  `kubectl get services`              List Services
  `kubectl get namespaces`            List namespaces
  `kubectl describe pod POD_NAME`     Show detailed Pod information
  `kubectl logs POD_NAME`             View container logs
  `kubectl logs -f POD_NAME`          Follow container logs
  `kubectl exec -it POD_NAME -- sh`   Open a shell inside a container
  `kubectl apply -f file.yaml`        Apply configuration
  `kubectl delete -f file.yaml`       Delete resources defined in YAML
  `kubectl get events`                View cluster events
  `kubectl top nodes`                 Check node resource usage
  `kubectl top pods`                  Check Pod resource usage

------------------------------------------------------------------------

# 3. Interview Questions -- Phase 1

Try answering these questions without looking at the explanations above.

### 1. What is Kubernetes and why do we use it?

Kubernetes is an open-source container orchestration platform that
automates deployment, scaling, networking, and management of
containerized applications.

### 2. What is the difference between Docker and Kubernetes?

Docker is primarily used to build and run containers. Kubernetes
orchestrates and manages containerized workloads across a cluster.

### 3. What are the main components of the Control Plane?

-   kube-apiserver
-   etcd
-   kube-scheduler
-   kube-controller-manager
-   cloud-controller-manager (when used)

### 4. What is the responsibility of kubelet?

It runs on worker nodes and ensures assigned Pods and their containers
run according to their specifications.

### 5. What is etcd?

A distributed key-value store that maintains Kubernetes cluster state
and configuration.

### 6. What happens when a Pod crashes?

The relevant controller detects that the actual replica count is below
the desired count and creates a replacement Pod. Kubelet also handles
container restarts according to the Pod's restart policy.

### 7. What is the difference between desired and actual state?

Desired state is what we want the cluster to maintain. Actual state is
the current cluster condition. Controllers reconcile the difference.

### 8. What is the difference between imperative and declarative approaches?

Imperative uses commands to perform specific actions. Declarative
defines the desired configuration in YAML and applies it using kubectl.

### 9. What is the difference between liveness and readiness probes?

Liveness determines whether a container needs restarting. Readiness
determines whether a Pod should receive traffic.

### 10. What is HPA?

Horizontal Pod Autoscaler automatically adjusts the number of Pod
replicas based on metrics such as CPU or memory utilization.

### 11. What is a rolling update?

It gradually replaces old application Pods with new Pods during a
Deployment update.

### 12. How do you roll back a Deployment?

Use:

``` bash
kubectl rollout undo deployment/DEPLOYMENT_NAME
```

------------------------------------------------------------------------

# 4. Practical Tasks -- Do These Yourself

Since you are working with Minikube, use it to practice these tasks.

## Task 1: Cluster Inspection

Start Minikube:

``` bash
minikube start
```

Check cluster information:

``` bash
kubectl cluster-info
```

List nodes:

``` bash
kubectl get nodes
```

List Pods across all namespaces:

``` bash
kubectl get pods -A
```

## Task 2: Create Your First Deployment

``` bash
kubectl create deployment nginx --image=nginx
```

Check Deployments:

``` bash
kubectl get deployments
```

Check Pods:

``` bash
kubectl get pods
```

## Task 3: Scale Your Application

``` bash
kubectl scale deployment nginx --replicas=3
```

Check Pods:

``` bash
kubectl get pods
```

Confirm that Kubernetes maintains 3 replicas.

## Task 4: Test Self-Healing

List Pods:

``` bash
kubectl get pods
```

Delete one Pod:

``` bash
kubectl delete pod <pod-name>
```

Check again:

``` bash
kubectl get pods
```

Observe how the Deployment's ReplicaSet creates a replacement Pod.

## Task 5: Perform a Rolling Update

``` bash
kubectl set image deployment/nginx nginx=nginx:1.26
```

Check rollout status:

``` bash
kubectl rollout status deployment/nginx
```

Check rollout history:

``` bash
kubectl rollout history deployment/nginx
```

## Task 6: Perform a Rollback

``` bash
kubectl rollout undo deployment/nginx
```

Check rollout history:

``` bash
kubectl rollout history deployment/nginx
```

Check Pods:

``` bash
kubectl get pods
```

------------------------------------------------------------------------

# 5. Phase 1 -- Final Revision Checklist

Use this checklist to track your learning progress. Mark a topic only
after you understand it and can explain it without referring to notes.

-   [ ] What is Kubernetes?
-   [ ] Container orchestration
-   [ ] Why Kubernetes is required
-   [ ] Docker vs Kubernetes
-   [ ] Kubernetes vs Docker Swarm
-   [ ] Kubernetes architecture
-   [ ] Control Plane components
-   [ ] Worker Node components
-   [ ] Kubernetes cluster
-   [ ] Control Plane vs Worker Node
-   [ ] Desired state vs actual state
-   [ ] Reconciliation loop
-   [ ] Declarative vs imperative approach
-   [ ] Kubernetes API
-   [ ] API groups and versions
-   [ ] Kubernetes objects and resources
-   [ ] Self-healing
-   [ ] Liveness, readiness, and startup probes
-   [ ] Horizontal Pod Autoscaler
-   [ ] Vertical Pod Autoscaler and Cluster Autoscaler
-   [ ] Rolling updates
-   [ ] Deployment rollback
-   [ ] Practical kubectl commands

------------------------------------------------------------------------

# 6. What Comes Next?

After completing Phase 1, move to the following Kubernetes learning
roadmap.

  -----------------------------------------------------------------------
  Phase                   Topics                  Priority
  ----------------------- ----------------------- -----------------------
  Phase 1                 Kubernetes Fundamentals Must Know
                          and Architecture        

  Phase 2                 Pods, ReplicaSets,      Must Know
                          Deployments,            
                          StatefulSets,           
                          DaemonSets, Jobs        

  Phase 3                 Namespaces, Services,   Must Know
                          DNS, ClusterIP,         
                          NodePort, LoadBalancer, 
                          Ingress                 

  Phase 4                 ConfigMaps, Secrets,    Must Know
                          Environment Variables   

  Phase 5                 Requests, Limits, QoS,  Must Know
                          Resource Management     

  Phase 6                 PV, PVC, StorageClass,  Must Know
                          Stateful Storage        

  Phase 7                 RBAC, Service Accounts, Must Know
                          Security, Network       
                          Policies                

  Phase 8                 HPA, VPA, Cluster       Must Know
                          Autoscaler, Scheduling  

  Phase 9                 Probes,                 Must Know
                          Troubleshooting,        
                          Debugging               

  Phase 10                Helm, Kustomize,        Advanced
                          GitOps, ArgoCD          

  Phase 11                Monitoring, Logging,    Must Know
                          Prometheus, Grafana     

  Phase 12                EKS, Production         Must Know
                          Architecture, CI/CD     
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## Recommended Learning Method

For every Kubernetes concept, understand these three things:

1.  **What is it?** -- Learn the definition and purpose.
2.  **Why do we need it?** -- Understand the real-world problem it
    solves.
3.  **How do we implement and troubleshoot it?** -- Practice commands,
    YAML manifests, and failure scenarios.

Don't rush through the topics. Practice each concept using Minikube and
try to explain it in your own words.

**Phase 1 completion goal:** You should be able to explain Kubernetes
architecture, describe how a Deployment creates and maintains Pods,
understand desired-state reconciliation, and demonstrate scaling,
self-healing, rolling updates, and rollbacks using kubectl.

------------------------------------------------------------------------

**End of Phase 1 -- Kubernetes Fundamentals and Architecture**
