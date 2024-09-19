### 1. General Cluster Commands
- Check cluster information: Shows details about the Kubernetes cluster, including the control plane and DNS information.
  `kubectl cluster-info
  `
- View nodes in the cluster:Lists all nodes in the Kubernetes cluster.
`kubectl get nodes
`
- View Kubernetes resources (pods, services, deployments, etc.):
  `kubectl get <resource_type>
  `
`kubectl get pods
kubectl get services
kubectl get deployments
`  
### 2. Working with Pods
- View all pods:
`kubectl get pods
` 
- View detailed pod information:
 `kubectl describe pod <pod_name>
`
- Create a pod from a YAML file:
  `kubectl apply -f <file.yaml>
  `
- Delete a pod:
    `kubectl delete pod <pod_name>
    `
- Get pod logs:
  `kubectl logs <pod_name>
  `
- Access a pod interactively (e.g., to debug):
  `kubectl exec -it <pod_name> -- /bin/bash
  `
### 3. Working with Deployments
- View deployments:
`kubectl get deployments
`
- Create a deployment:
  `kubectl apply -f <deployment.yaml>
  `
- Delete a deployment:
  `kubectl delete deployment <deployment_name>
  `
- Scale a deployment:
  `kubectl scale deployment <deployment_name> --replicas=<number_of_replicas>
  `
- Update a deployment:
  `kubectl set image deployment/<deployment_name> <container_name>=<new_image>
  `
### 4. Working with Services
- View services:
  `kubectl get services
  `
- Create a service:
  `kubectl apply -f <service.yaml>
  `
- Delete a service:
  `kubectl delete service <service_name>
  `

 ### 5. Working with Namespaces
 - View namespaces:
   `kubectl get namespaces
   `
 - Create a namespace:
`kubectl create namespace <namespace_name>
`
- Switch to a different namespace:
  `kubectl config set-context --current --namespace=<namespace_name>
  `
- Delete a namespace:
  `kubectl delete namespace <namespace_name>
  `
### 6. Working with Config Maps & Secrets
- Create a ConfigMap:
  `kubectl create configmap <configmap_name> --from-literal=<key>=<value>
  `
- View ConfigMaps:
`kubectl get configmaps
`
- Create a Secret:
  `kubectl create secret generic <secret_name> --from-literal=<key>=<value>
  `
- View Secrets:
`kubectl get secrets
`
### 7. Managing Resources
- Apply changes from a YAML file:
  `kubectl apply -f <file.yaml>`
- Delete resources defined in a YAML file:
  `kubectl delete -f <file.yaml>`
 - Edit a resource (like deployment):
   `kubectl edit deployment <deployment_name>'
      
### 8. Events and Monitoring
- View recent events:
  `kubectl get events`
- View the status of all resources:
  `kubectl get all`

### 9. Context & Configuration
- View current context (cluster and namespace you're working in):
  `kubectl config current-context`
 - Set a different context (switch cluster):
   `kubectl config use-context <context_name> `

    
