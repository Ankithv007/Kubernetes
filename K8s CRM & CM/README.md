### Custom Resource Definition (CRD) and Custom Resources (CRs)
Custom Resource (CR) is an extension of the Kubernetes API that allows you to define your own objects or configurations, going beyond the standard Kubernetes resources (like Pods, Services, ConfigMaps, etc.). Custom resources enable you to introduce new types of objects that Kubernetes does not natively provide, making the platform highly extensible

#### Custom Resource Definition (CRD)
- Before creating and managing custom resources, you need to define them using a Custom Resource Definition (CRD). This CRD is essentially a schema that tells Kubernetes about the structure of the new resource.
- Once the CRD is created, Kubernetes API knows how to recognize and handle this new type of object.

#### Custom Resources (CRs)
- These are instances of the CRD. Just like you create Pods using the Pod API, you can create custom objects once the CRD is defined.
- CRs can be used to represent almost anything in your system, like external services, apps, databases, etc.

#### Controllers:
- While a CRD defines the schema and structure, a Controller is often used in conjunction with custom resources to define custom logic on how the resources should be managed or controlled.
- For example, you can write a controller that ensures that a certain number of custom resources are always running or that takes action when specific conditions are met.

  #### CNCF (Cloud Native Computing Foundation)
  CNCF serves as a home for various open-source projects that support cloud-native architectures. Some of the most well-known CNCF projects include Kubernetes, Prometheus, Envoy, Helm, gRPC, and etcd. The CNCF provides governance, community support, and infrastructure to ensure that these projects can grow and mature effectively.
 #### What is Cloud-Native?
  - Cloud-native refers to designing, building, and running applications that take full advantage of cloud computing architectures. Key principles of cloud-native applications include:

- Microservices: Decomposing applications into small, loosely coupled services.
- Containers: Using lightweight, portable containers (e.g., Docker) to encapsulate services.
- Dynamic orchestration: Automatically managing the deployment, scaling, and lifecycle of services (e.g., Kubernetes).
- Declarative APIs: Allowing infrastructure and application configurations to be managed via code


