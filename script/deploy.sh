#!/bin/bash
set -e

echo "Updating kubeconfig..."
aws eks update-kubeconfig --region ap-south-1 --name brain-tasks-app-cluster

# --- Add subnet tagging here ---
echo "Tagging subnets for ALB usage..."

CLUSTER_NAME="brain-tasks-app-cluster"
SUBNET_IDS=("subnet-0b7904bf2870d15da" "subnet-038d15c37dad6b59c" "subnet-0171623c1797f324a")  # Replace with your actual subnet IDs

for subnet in "${SUBNET_IDS[@]}"; do
  echo "Tagging subnet $subnet..."
  aws ec2 create-tags --resources "$subnet" --tags Key=kubernetes.io/cluster/$CLUSTER_NAME,Value=shared
  aws ec2 create-tags --resources "$subnet" --tags Key=kubernetes.io/role/elb,Value=1
done

echo "Subnet tagging completed."
# --- End subnet tagging ---

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
kubectl apply -f /app/k8s/ingress.yaml

echo "Deployment completed."
