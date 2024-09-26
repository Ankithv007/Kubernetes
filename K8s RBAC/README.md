#### RBAC, or Role-Based Access Control, is a method of regulating access to computer or network resources based on the roles of individual users within an organization.
### What is RBAC?
- Roles: Roles are defined sets of permissions that specify what actions can be performed on specific resources. For example, a role might allow users to read data from a database but not modify it.
- Role Bindings: Role bindings associate a user or a group of users with a specific role. This means that users assigned to a role can perform the actions specified by that role.
- Cluster Roles and Bindings: In Kubernetes, ClusterRoles are similar to Roles but apply across the entire cluster rather than a specific namespace. ClusterRoleBindings associate users or groups with ClusterRoles.

### Why Use RBAC?
- Security: RBAC helps enhance security by ensuring that users only have access to the resources they need to perform their jobs, minimizing the risk of unauthorized access.
- Scalability: As organizations grow, managing permissions through RBAC makes it easier to scale access control without having to adjust permissions for each user individually.
- Auditing and Compliance: RBAC makes it easier to audit access control and demonstrate compliance with regulatory standards, as roles and permissions can be documented and reviewed.
- Separation of Duties: By using roles, organizations can enforce the principle of separation of duties, reducing the risk of fraud and error by ensuring that no single user has complete control over a critical function.

### Authentication and authorization 
![Authentication](https://github.com/Ankithv007/Kubernetes/blob/main/K8s%20RBAC/images/authentication%201.png)


