# DevOps GCP Project

A hands-on DevOps project demonstrating containerization, Infrastructure as Code, CI, health checks, and local GCP service emulation.

## Architecture

```text
Developer
   |
   v
Git / GitHub
   |
   v
GitHub Actions CI
   |
   +--> Python syntax check
   +--> Flask health check
   +--> Docker image build
   |
   v
Local Deployment
   |
   v
Terraform
   |
   v
floci-gcp
   |
   +--> Cloud Storage
   |
   +--> Cloud Run
          |
          v
     Flask Container
```

## Technologies Used

- Python
- Flask
- Docker
- Terraform
- Git
- GitHub
- GitHub Actions
- floci-gcp
- Google Cloud Storage API
- Cloud Run API

## Application

The project contains a simple Flask application running on port `8080`.

Main endpoint:

```text
http://localhost:8080
```

Health endpoint:

```text
http://localhost:8080/health
```

The health endpoint returns HTTP `200` when the application is healthy.

## Docker

Build the application image:

```bash
docker build -t devops-gcp-app:latest ./app
```

Run it locally:

```bash
docker run -p 8080:8080 devops-gcp-app:latest
```

The port mapping forwards host port `8080` to port `8080` inside the container.

## Terraform

Terraform is used to manage the project's infrastructure.

The local environment uses `floci-gcp` to emulate supported Google Cloud APIs.

Terraform manages:

- Cloud Storage bucket
- Cloud Run service

Typical Terraform workflow:

```bash
cd terraform

terraform init
terraform validate
terraform plan
terraform apply
```

## floci-gcp

floci-gcp provides local emulation of the GCP services used by this project.

It runs locally on port `4588`.

The Terraform Google provider uses custom endpoints so requests are sent to floci-gcp instead of real Google Cloud.

> This project uses local GCP emulation for learning and development. It is not a production deployment to Google Cloud.

## Continuous Integration

GitHub Actions runs automatically when code is pushed to the `main` branch.

The CI pipeline:

1. Checks out the repository
2. Sets up Python
3. Installs dependencies
4. Checks Python syntax
5. Starts the Flask application
6. Tests the `/health` endpoint
7. Builds the Docker image

If any step fails, the CI workflow fails.

## Failure Testing

The health endpoint was intentionally changed to return HTTP `500`.

The GitHub Actions health check detected the failure and stopped the pipeline.

After restoring the endpoint to HTTP `200`, the CI pipeline passed again.

This demonstrates automated failure detection in the CI workflow.

## Local Deployment

The deployment script builds the latest Docker image and applies the Terraform configuration:

```bash
./scripts/deploy.sh
```

Deployment flow:

```text
Docker Build
    |
    v
Terraform Apply
    |
    v
floci-gcp
    |
    v
Cloud Run
    |
    v
Flask Container
```

## Project Structure

```text
devops-gcp-project/
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── terraform/
│   ├── main.tf
│   └── .terraform.lock.hcl
├── scripts/
│   └── deploy.sh
├── .gitignore
└── README.md
```

## What I Learned

This project demonstrates:

- Containerizing a Python application with Docker
- Docker port mapping and container networking basics
- Managing infrastructure using Terraform
- Working with Terraform providers and state
- Running GCP-compatible services locally with floci-gcp
- Deploying a container through Cloud Run emulation
- Using Git and GitHub for version control
- Building a CI pipeline with GitHub Actions
- Implementing application health checks
- Testing CI failure and recovery
- Automating local deployment
