# CloudL Kubernetes Deployment with EFK Stack

## 📋 Overview
This repository contains the complete infrastructure and application code for deploying the CloudL application on Kubernetes with a comprehensive EFK (Elasticsearch, Fluentd, Kibana) logging stack, S3 log archiving, and automated backup solutions.

## 🏗️ Architecture
```bash
CloudL Application → Fluentd (Log Collection) → Elasticsearch (Real-time Storage) → Kibana (Visualization)
↓
AWS S3 Bucket
├── info/ (INFO logs)
└── error/ (ERROR logs)
```
## 📁 Repository Structure
```bash
cloudl-k8s/
├── k8s/ # CloudL application Kubernetes manifests
│ ├── cloudl-client-deployment-frontend.yml
│ ├── cloudl-server-deployment.yml
│ ├── mongo.yml # MongoDB deployment
│ ├── mongo-express.yml # MongoDB Express UI
│ ├── mongo-pvc.yaml # MongoDB persistent volume
│ ├── mongodb-service.yml
│ ├── configmap.yml
│ ├── secret.yml
│ ├── namespace.yaml
│ ├── ingress.yaml
│ ├── cluster.sh
│ ├── deploy.sh # Deployment script
│ └── undeploy.sh # Cleanup script
├── efk/ # EFK Stack configuration
│ ├── elasticsearch-deployment.yml
│ ├── elasticsearch-service.yml
│ ├── elasticsearch.yml
│ ├── fluentd-config.yml
│ ├── fluentd-daemonset.yml
│ ├── fluentd-s3-config.yml 
│ ├── fluentd-daemonset-s3.yml
│ ├── fluentd-rbac.yml
│ ├── kibana-deployment.yml
│ ├── kibana-service.yml
│ ├── elasticsearch-backup.yml
│ └── elasticsearch-backup-cronjob.yml
├── backend/ # Backend application code
├── frontend/ # Frontend application code
├── Jenkinsfile.ci # CI pipeline configuration
├── Jenkinsfile.cd # CD pipeline configuration
└── README.md
```


## 🚀 Quick Start
### Prerequisites
- Kubernetes cluster (k3s tested)
- AWS account with S3 bucket
- kubectl configured
- AWS IAM credentials with S3 access

### 1. Deploy CloudL Application
```bash
cd k8s/
./deploy.sh
```

### Kustomize overlays (alternative)

There's a kustomize-friendly version of the manifests in `Kustomize-k8s/` with a `base/` and `overlays/` for `dev`, `staging`, and `prod`.

Build or apply an overlay directly:

```bash
# build to stdout
kubectl kustomize Kustomize-k8s/overlays/dev

# apply to cluster
kubectl apply -k Kustomize-k8s/overlays/prod
```
### 2. Deploy EFK Stack
```bash
cd ../efk/
kubectl apply -f elasticsearch-deployment.yml
kubectl apply -f elasticsearch-service.yml
kubectl apply -f fluentd-config.yml
kubectl apply -f fluentd-daemonset.yml
kubectl apply -f kibana-deployment.yml
kubectl apply -f kibana-service.yml
kubectl apply -f fluentd-rbac.yml
```
### 3. Configure S3 Integration
```bash
kubectl create secret generic aws-s3-credentials \
  --namespace=logging \
  --from-literal=AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY \
  --from-literal=AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY

kubectl apply -f fluentd-s3-config.yml
kubectl apply -f fluentd-daemonset-s3.yml
```
### 4. Setup Backups
```bash
kubectl apply -f elasticsearch-backup-cronjob.yml
```


