### how to create user 
#### Generate a 2048-bit RSA private key:
-  generates a 2048-bit RSA private key 
```
 openssl genrsa -out ankith.key 2048
```
#### Create a Certificate Signing Request (CSR):
- creates a Certificate Signing Request (CSR) ,private key, with the subject's Common Name (CN) set to "ankith", organization (O) to "dev", and another organization (O) to "example.org".,set as developer  in some example.org 
```
openssl req -new -key ankith.key -out ankith.csr -subj "/CN=ankith/O=dev/O=example.org"
```
#### List files:
```
ls | grep ankith
```
#### Sign the CSR using the Minikube CA:
- CSR using the Minikube CA certificate and key, creating the signed certificate ankith.crt valid for 730 days.
```
openssl x509 -req -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -days 730 -in ankith.csr -out ankith.crt
```
#### Configure Kubernetes credentials:
- configures Kubernetes to use the ankith.crt certificate and ankith.key private key for authenticating the user "ankith".
```
kubectl config set-credentials ankith --client-certificate=ankith.crt --client-key=ankith.key
```
#### Check the Kubernetes config:
- check by useing
```
cat ~/.kube/config
```
#### Create a new Kubernetes context:
- creates a new Kubernetes context named ankith-minikube, associating it with the minikube cluster, the user ankith, and the default namespace for easier context switching.
```
 kubectl config set-context ankith-minikube --cluster=minikube --user=ankith --namespace=default
```
#### List available contexts:
-  lists all available Kubernetes contexts in the configuration, showing their names, associated clusters, users, and namespaces, allowing users to view and manage their current and available contexts.
```
kubectl config get-contexts
```
#### Switch to the new context:
- after creating to use the create name context
```
kubectl config use-context ankith-minikube
```
- after the creation of user and will have to give them t access with the help of their role for that we create role ,role binding,cluster role and cluster role binding
  - role
 ```
     apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods","pods/log"]
  verbs: ["get", "watch", "list"]
 ```
- creating Rolebinding.yaml
```
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
# You need to already have a Role named "pod-reader" in that namespace.
kind: RoleBinding
metadata:
  name: read-pods
subjects:
# You can specify more than one "subject"
- kind: User
  name: ankith # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```
- The main reason to use ClusterRole and ClusterRoleBinding in Kubernetes is to grant permissions across the entire cluster rather than just within a specific namespace, allowing for consistent and centralized access control for resources that may exist in multiple namespaces or for cluster-wide resources.
#### ClusterRole:
- A ClusterRole defines a set of permissions that can be applied at the cluster level. It can be used to manage access to resources across all namespaces or to resources that exist only at the cluster level (e.g., nodes, persistent volumes).
- It is useful for granting permissions that should be applied globally, such as for cluster administrators or applications that need access to multiple namespaces.
#### ClusterRoleBinding:
- A ClusterRoleBinding associates a ClusterRole with a user, group, or service account at the cluster level. This allows the specified entity to perform actions defined in the ClusterRole across the entire cluster.
- It simplifies management by enabling you to grant access to multiple users or service accounts without needing to create separate Role and RoleBinding for each namespace.
#### Namespace
- A namespace in Kubernetes is a logical partition within a cluster that allows you to isolate resources for different projects, teams, or environments. Namespaces help manage resources more effectively by providing:

- Isolation: Resources in different namespaces are isolated from one another, preventing name collisions.
- Resource Management: You can apply resource quotas and policies at the namespace level, enabling better control over resource consumption.
- Organizational Structure: Namespaces help organize cluster resources, making it easier to manage and maintain complex applications and multi-tenant environments.
- in Kubernetes, a default service account is automatically created for each namespace. This service account is named default and can be used by pods in that namespace when no specific service account is specified. It provides a way for pods to interact with the Kubernetes API without needing to create additional service accounts for each application or pod.
####  service account
A service account in Kubernetes is a special type of account designed for processes (like pods) to interact with the Kubernetes API. Unlike user accounts, which are intended for human users, service accounts are intended for automated processes and applications running within the cluster. Key features include:
- Authentication: Service accounts provide a way for pods to authenticate with the Kubernetes API. Each service account is associated with a set of credentials (a token) that can be used to access the API.
- Authorization: You can control what actions a service account can perform in the cluster by assigning it specific roles or cluster roles using RoleBindings or ClusterRoleBindings.
- Isolation: Different applications can have their own service accounts, allowing you to implement least privilege access by granting only the necessary permissions.
- Automatic Injection: When a pod is created without a specified service account, Kubernetes automatically associates it with the default service account in its namespace.
Service accounts are particularly useful for applications that need to communicate with the Kubernetes API to manage resources, such as controllers, operators, and applications running inside the cluster.

- ClusterRole:
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods","pods/log"]
  verbs: ["get", "watch", "list"]
```
- clusterrolebinding.yaml
```
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "dave" to read secrets in the "development" namespace.
# You need to already have a ClusterRole named "secret-reader".
kind: ClusterRoleBinding
metadata:
  name: read-secrets
  #
  # The namespace of the RoleBinding determines where the permissions are granted.
  # This only grants permissions within the "development" namespace.
subjects:
- kind: User
  name: ankith # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```
- clusert role binding for group
```
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "dave" to read secrets in the "development" namespace.
# You need to already have a ClusterRole named "secret-reader".
kind: ClusterRoleBinding
metadata:
  name: read-secrets
  #
  # The namespace of the RoleBinding determines where the permissions are granted.
  # This only grants permissions within the "development" namespace.
subjects:
- kind: User
  name: ankith # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
- kind: Group
  name: dev # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

```
kubectl auth can-i watch pod --as ankith
kubectl auth can-i list pod --as ankith
kubectl auth can-i create pod --as ankith
```








