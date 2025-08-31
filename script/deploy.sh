#!/bin/bash

set -e

echo "Updating kubeconfig..."
aws eks update-kubeconfig --region ap-south-1 --name brain-tasks-app-cluster

# Annotate the AWS Load Balancer Controller service account
ROLE_ARN="arn:aws:iam::551210489378:role/AWSLoadBalancerControllerRole"

kubectl annotate serviceaccount \
  -n kube-system aws-load-balancer-controller \
  eks.amazonaws.com/role-arn=$ROLE_ARN \
  --overwrite

# Restart the ALB controller to pick up the new IAM role
kubectl rollout restart deployment aws-load-balancer-controller -n kube-system

echo "Applying Kubernetes manifests..."
kubectl apply -f /app/k8s/deployment.yaml
kubectl apply -f /app/k8s/service.yaml
kubectl apply -f k8s/ingress.yaml

echo "Deployment completed."
