### A Kubernetes (K8s) Deployment is a resource in Kubernetes that manages the desired state of your application. It defines how your application should run on a Kubernetes cluster and ensures that your application is always in the correct state, even if nodes fail or get updated

## What is a K8s Deployment?
- Declarative Updates: A Deployment is used to declare the desired state of your application, such as the number of replicas, the image version, or resource limits. You provide a YAML/JSON configuration file, and Kubernetes will work to ensure the system matches your declaration.

- Replica Management: You can specify how many instances (replicas) of your application you want to run. Kubernetes ensures that this number is maintained by replacing any failed instances.

- Rolling Updates: Deployments allow for rolling updates, meaning that new versions of your application can be deployed gradually, replacing old pods without downtime.

- Self-Healing: If a pod crashes or fails, Kubernetes will automatically restart it, ensuring high availability.

- Version Control: You can easily roll back to a previous version if something goes wrong with the new deployment.

## Why Use K8s Deployment?
- High Availability: A Deployment ensures that your application runs the desired number of replicas, automatically recovering from failures, ensuring high availability of your app.

- Scalability: You can scale your application horizontally by increasing the number of replicas with just a configuration update. Kubernetes will distribute these replicas across the nodes in the cluster.

- Zero Downtime Deployment: Rolling updates allow you to upgrade your app without interrupting service, providing a seamless user experience.

- Self-Healing: If pods become unhealthy, the Deployment controller will create new pods to replace the failing ones.

- Automated Rollbacks: If an update fails, Kubernetes can automatically roll back to a previous, working version of your app.

### Create a deployment.yaml file:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment    
spec:
  replicas: 3    ### give as much you want
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app   ## it's comes when you create service copy as the same and paste there
    spec:
      containers:
      - name: my-container
        image: nginx:latest  ### change to your image
        ports:
        - containerPort: 80   ### change to same as your image Dockerfile port
```
#### Apply the Deployment:
``` kubectl apply -f deployment.yaml ```

#### List Deployments
``` kubectl get deployments ```

####  Describe a Deployment
``` kubectl describe deployment my-deployment```
#### Scale a Deployment
``` kubectl scale deployment my-deployment --replicas=5```
#### Delete a Deployment
``` kubectl delete deployment my-deployment ```
 #### Basic Rollout Commands:
#### Check Rollout Status: This command lets you monitor the progress of a deployment update. It shows if the update is ongoing, completed, or failed.
``` kubectl rollout status deployment/my-deployment ```

#### View Rollout History: This command displays a list of past rollouts, showing each version and the changes that were applied.
``` kubectl rollout history deployment/my-deployment```
#### Undo (Rollback) a Rollout: If something goes wrong with a deployment, you can revert the deployment to a previous version:
``` kubectl rollout undo deployment/my-deployment ```
#### Pause a Rollout: You can pause a deployment if you want to stop further updates from happening
``` kubectl rollout pause deployment/my-deployment ```
#### Resume a Paused Rollout: Once a rollout is paused, you can resume it when you're ready to continue the update:
``` kubectl rollout resume deployment/my-deployment```

### Why Rollout Is Important:
- Zero Downtime: Kubernetes uses rolling updates by default, ensuring that your application remains available while new versions are being deployed.
- Safe Updates: If something goes wrong during a rollout, Kubernetes can stop or roll back the changes, maintaining system stability.
- Easy Rollbacks: If an update fails, it's easy to undo it and go back to a previous working version without hassle.
#### Rollout management helps ensure that updates to applications happen smoothly and reliably in production environments.





