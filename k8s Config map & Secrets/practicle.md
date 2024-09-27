### Config Map
- deployment.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web-app
        image: ankithbv007/deepu:v1
        env:
         - name: DB-PORT
           valueFrom:
            configMapKeyRef:
             name: test-cm
             key: db-port
        ports:
        - containerPort: 8000
```
```
kubectl apply -f <deploument.yaml>
```
- create service.yaml
- cm.yaml
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: test-cm
data:
  db-port: "3309"
```
```
kubectl get cm
```
```
kubectl describe  cm <cm name>
```
```
kubectl apply -f <config map name>
```
#### so here what happen evry time if the db pots is changes we have to re apply the deployment its like we are hard coding the values inside te deployment top overcome this 
#### we use the config map 
```
 kubectl get pod
```
```
kubectl exec -it <pod name > -- /bin/bash/
```
- inside the pod
```
env | grep DB
```
### useing the volume mount (in production we can able to stop the conatiner as well if we stop will face the traffic loss for that we create the volume mount )

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web-app
        image: ankithbv007/deepu:v1
        volumeMounts:
        - name: db-connection    
          mountPath: /opt
          readOnly: true
        ports:
        - containerPort: 8000
      volumes:
      - name: db-connection      
        configMap:
          name: test-cm 
```
- apply the config if you have change
- apply the deployment
- get the pod
- open the pod with exec -it
```
 kubectl get pod
```
```
kubectl exec -it <pod name > -- /bin/bash/
```
```
cd opt
cat db-port | more
```

- change the config map again get into pod and verify does the port is  changed or not

# secretes (imperative way)
```
kubectl  create secret generic test-secrete --from-literal=db-port="3309"
```
```
kubectl get secret
```
```
 kubectl describe secret <test-secrete (secrete name)>
```
```
 kubectl edit secret test-secrete
```
```
echo MzMwOQ== |base64 --decode
```

| Command          | Creates Resources | Updates Existing Resources | Ideal Use Case                                                  |
|------------------|-------------------|----------------------------|-----------------------------------------------------------------|
| `kubectl create` | Yes               | No                         | For creating resources once and when you're sure it doesn’t already exist. |
| `kubectl apply`  | Yes               | Yes                        | For managing resources over time, allowing updates and ensuring the resource is always in the desired state. |



