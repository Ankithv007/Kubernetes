## Practice Example: "Greet" Custom Resource
```
- A CRD named greets.demo.k8s.com
- A Custom Resource (CR) instance: hello-greet
- Then test CRUD operations

```
1.  Create the CRD (Definition)
```yaml

apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: greets.demo.k8s.com
spec:
  group: demo.k8s.com
  names:
    plural: greets
    singular: greet
    kind: Greet
    shortNames:
      - grt
  scope: Namespaced
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                message:
                  type: string
                from:
                  type: string

```
- kubectl apply -f greet-crd.yaml

- kubectl get crd
- kubectl describe crd greets.demo.k8s.com


2. Create a Custom Resource (CR)
```yaml

apiVersion: demo.k8s.com/v1
kind: Greet
metadata:
  name: hello-greet
spec:
  message: "Hello Kubernetes!"
  from: "Ankith"

```
- kubectl apply -f greet-cr.yaml

- kubectl get greets
- kubectl get greets -o yaml
- kubectl describe greet hello-greet
- kubectl delete greet hello-greet


- kubectl get crd

3. Delete the CRD
- kubectl delete crd greets.demo.k8s.com
