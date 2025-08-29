#!/bin/bash

set -e

echo "Updating kubeconfig..."
aws eks update-kubeconfig --region ap-south-1 --name brain-tasks-app-cluster

echo "Applying Kubernetes manifests..."
kubectl apply -f /app/k8s/deployment.yaml
kubectl apply -f /app/k8s/service.yaml

echo "Deployment completed."
