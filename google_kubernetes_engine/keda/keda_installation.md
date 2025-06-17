# Terraform Project for Kubernetes with KEDA

This repository contains Terraform configurations, likely for managing Kubernetes resources and deploying KEDA (Kubernetes Event-driven Autoscaling).

## KEDA Installation

The following commands are used to install KEDA and its HTTP add-on into a Kubernetes cluster using Helm.

```bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update
helm upgrade --install keda kedacore/keda --namespace keda --create-namespace --wait
helm install http-add-on kedacore/keda-add-ons-http \
  --create-namespace --namespace keda \
  --set interceptor.responseHeaderTimeout=120s
kubectl get pods -n keda
```

## Usage

(You can add instructions here on how to use the Terraform configurations in this project, e.g., `terraform init`, `terraform plan`, `terraform apply`.)