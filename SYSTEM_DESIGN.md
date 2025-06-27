---
# SYSTEM_DESIGN.md

# System Design: Spring Boot CRUD Microservice on AWS EKS

## 1. Overview
This system is a versioned Spring Boot CRUD microservice for managing products. The system is containerized using Docker, orchestrated using Kubernetes (AWS EKS), and deployed via a GitHub Actions CI/CD pipeline.

---

## 2. Architecture Diagram
```
+-----------------+         +------------------+         +-------------------+
|  GitHub Repo    |  --->   | GitHub Actions   |  --->   |  Docker Hub       |
| (Code + YAMLs)  |         | (CI/CD Workflow) |         | (Versioned Images)|
+-----------------+         +------------------+         +-------------------+
                                                 |
                                                 v
                                          +---------------+
                                          |  AWS EKS      |
                                          |  (Kubernetes) |
                                          +---------------+
                                                 |
                      +-------------------+------+-------------------+
                      |                   |                          |
                      v                   v                          v
              product-v1            product-v1-1                product-v2
              (v1.0.0)              (v1.1.0)                    (v2.0.0)

    - Deployment.yaml        - Deployment.yaml        - Deployment.yaml
    - Service.yaml           - Service.yaml           - Service.yaml
    - Ingress.yaml           - Ingress.yaml           - Ingress.yaml
```

---

## 3. Key Components

### 3.1. Microservice
- Framework: Spring Boot
- REST Endpoints:
  - `GET /products`
  - `POST /addProduct`
  - `GET /productById/{id}`
  - `PUT /update`
  - `DELETE /delete/{id}`
  - `GET /products/search` (v1.1+)
  - `GET /products/search?keyword=...` (v2.0+)

### 3.2. Docker
- Dockerfile builds JAR and packages it into versioned images
- Images pushed to Docker Hub: `tkg31/spring-boot-crud-app:<version>`

### 3.3. Kubernetes (EKS)
- Cluster created using `eksctl`
- Namespaces for isolation:
  - `product-v1`
  - `product-v1-1`
  - `product-v2`
- Each namespace includes:
  - Deployment
  - Service
  - Ingress

### 3.4. Ingress Controller
- Ingress routing based on path:
  - `/v1/*` → v1.0.0
  - `/v1-1/*` → v1.1.0
  - `/v2/*` → v2.0.0

---

## 4. CI/CD Pipeline (GitHub Actions)

### Triggers:
- On push to version branches or tags (e.g. `v1.0.0`, `v2.0.0`)

### Steps:
1. Checkout Code
2. Build Docker Image
3. Push to Docker Hub
4. Configure AWS EKS via kubeconfig
5. Deploy version-specific manifests:
   - `deployment.yaml`
   - `service.yaml`
   - `ingress.yaml`

---

## 5. Version Management

- **v1.0.0**: Basic `/products` and `/health` endpoints
- **v1.1.0**: Added search by keyword
- **v2.0.0**: Improved search + query param + error handling

All version tags pushed using semantic versioning and logged in `CHANGELOG.md`.

---

## 6. Secrets & Security

- Docker Hub credentials stored as GitHub Secrets:
  - `DOCKER_USERNAME`, `DOCKER_PASSWORD`
- AWS access configured with:
  - `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`
  - `KUBE_CONFIG` (base64 encoded kubeconfig)

---

## 7. Testing

- Endpoints tested using `curl` and browser
- Example:
  ```bash
  curl http://<Ingress-IP>/v1/products
  curl http://<Ingress-IP>/v2/products/search?keyword=test
  ```

---

## 8. Tools Used

| Component      | Tool/Service      |
|----------------|-------------------|
| Codebase       | Spring Boot       |
| Containerization | Docker          |
| Orchestration  | Kubernetes (EKS)  |
| CI/CD          | GitHub Actions    |
| Registry       | Docker Hub        |
| Cloud Provider | AWS EKS           |

---

## 9. Conclusion

This project demonstrates a fully automated microservice lifecycle — from versioned development to Docker-based packaging, Kubernetes-based deployment on AWS, and a GitHub Actions CI/CD pipeline. It ensures modular deployment, scalability, and maintainability.

