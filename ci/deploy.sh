#!/bin/bash
# TODO: create pipeline from script 

set -euo pipefail

# --- Configuration ---
APP_NAME="app-template"
AWS_REGION="eu-west-1"
ECR_REPO_NAME="$APP_NAME"
ECS_DIR="ecs-template"
IMAGE_TAG="latest"

echo "Stage: ECR Login - Build and Push Image"
aws ecr get-login-password --region "$AWS_REGION" | \
  docker login --username AWS \
  --password-stdin "$(aws sts get-caller-identity --query Account --output text).dkr.ecr.${AWS_REGION}.amazonaws.com"

REPO_URI=$(aws ecr describe-repositories \
  --repository-names "$ECR_REPO_NAME" \
  --region "$AWS_REGION" \
  --query 'repositories[0].repositoryUri' \
  --output text)

docker build -t "$ECR_REPO_NAME" "$ECS_DIR/app"
docker tag "$ECR_REPO_NAME:latest" "$REPO_URI:$IMAGE_TAG"
docker push "$REPO_URI:$IMAGE_TAG"

echo "Stage: Terraform Plan + Apply"
cd "$ECS_DIR/terraform"
terraform init
terraform apply -auto-approve \
  -var="name=$APP_NAME" \
  -var="region=$AWS_REGION"
