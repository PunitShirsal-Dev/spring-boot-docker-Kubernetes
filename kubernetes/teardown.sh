#!/bin/bash

NAMESPACE="spring-boot-namespace"

echo "Cleaning up Minikube deployment..."

# Delete resources
kubectl delete -f kubernetes/app/ --ignore-not-found
kubectl delete -f kubernetes/postgres/ --ignore-not-found

# Delete namespace
kubectl delete namespace $NAMESPACE --ignore-not-found

# Clean Minikube images
minikube image rm spring-boot-app/spring-boot-docker-kubernetes:1.0.0

# Reset context
kubectl config set-context --current --namespace=default

echo "Cleanup complete!"