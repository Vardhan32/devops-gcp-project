#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Building Docker image..."
docker build -t devops-gcp-app:latest ./app

echo "Applying Terraform..."
cd terraform
terraform apply -auto-approve

echo "Deployment complete."
