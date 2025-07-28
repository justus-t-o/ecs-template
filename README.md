# ECS Terraform Template

This repository contains Terraform configurations to deploy a simple Python app template on AWS ECS with Fargate. It also includes a secure setup for monitoring using Grafana Cloud via AWS CloudWatch.

---

## Features

* Deploy a Python app to ECS Fargate
* Create and push Docker image to AWS ECR
* Setup ECS Cluster, Task Definition, Service, and Application Load Balancer (ALB)
* Configure CloudWatch Logs for ECS task logging
* IAM role/user for Grafana Cloud monitoring with minimal permissions
* Deploy script for building, pushing Docker image, and applying Terraform


---

## Usage

Use the included script to deploy:

```bash
./ci/deploy.sh
```



