# 🛠️ Spring Boot CRUD Microservice with CI/CD on Kubernetes (EKS)

This project is a simple Product Catalog CRUD microservice built using **Spring Boot**, containerized with **Docker**, deployed on **Kubernetes (EKS)**, and automated via **GitHub Actions**.

---

## 📌 Features

- ✅ RESTful CRUD API for managing products
- ✅ Built using Spring Boot + MySQL
- ✅ Dockerized and deployed on Kubernetes (Amazon EKS)
- ✅ Versioned deployments: `v1.0.0`, `v1.1.0`, `v2.0.0`
- ✅ CI/CD pipeline using GitHub Actions
- ✅ Public Docker images pushed to [Docker Hub](https://hub.docker.com/u/tkg31)

---

## 📁 Version Highlights

| Version   | Features                                                                 |
|-----------|--------------------------------------------------------------------------|
| `v1.0.0`  | `/health`, `/products` endpoints                                         |
| `v1.1.0`  | Added `/products/search?name=...` for keyword-based search              |
| `v2.0.0`  | Enhanced search with query params & error handling                       |

---

## 🚀 CI/CD Pipeline (GitHub Actions)

On every push to version branches (`v1.0.0`, `v1.1.0`, `v2.0.0`):

1. ✅ Build and push Docker image to Docker Hub
2. ✅ Deploy the corresponding version to EKS
3. ✅ Apply deployment, service, ingress YAMLs
4. ✅ Automatically create namespaces

---

## ⚙️ Kubernetes Structure

- `k8s/v1/` → manifests for v1.0.0
- `k8s/v1.1/` → manifests for v1.1.0
- `k8s/v2/` → manifests for v2.0.0

Each version includes:
- `deployment.yaml`
- `service.yaml`
- `ingress.yaml`


📦 Technologies Used

    Java 17
    Spring Boot
    Docker
    GitHub Actions
    Kubernetes (EKS)
    MySQL (K8s StatefulSet)
    NGINX Ingress Controller
