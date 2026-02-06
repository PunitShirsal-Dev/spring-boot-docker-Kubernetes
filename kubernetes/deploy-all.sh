#!/bin/bash

NAMESPACE="spring-boot-namespace"

echo "Deploying to Minikube..."

# Create namespace if not exists
kubectl create namespace $NAMESPACE 2>/dev/null || true

# Set context
kubectl config set-context --current --namespace=$NAMESPACE

# Deploy PostgreSQL
echo "Deploying PostgreSQL..."
kubectl apply -f kubernetes/postgres/

# Wait for PostgreSQL
echo "Waiting for PostgreSQL..."
kubectl wait --for=condition=ready pod -l app=postgres --timeout=120s

# Deploy Spring Boot
echo "Deploying Spring Boot..."
kubectl apply -f kubernetes/app/

# Wait for Spring Boot
echo "Waiting for Spring Boot..."
kubectl wait --for=condition=ready pod -l app=spring-boot-app --timeout=180s

# Show status
echo "Deployment Status:"
kubectl get all -n $NAMESPACE

# Get URLs
echo -e "\nAccess URLs:"
echo "1. Minikube Dashboard: minikube dashboard"
echo "2. Application: http://$(minikube ip):30080"
echo "3. Port Forward: kubectl port-forward svc/spring-boot-service 8080:80 -n $NAMESPACE"