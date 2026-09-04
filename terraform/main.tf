terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
 project = "devops-gcp-project"
 region  = "us-central"
 service_usage_custom_endpoint = "http://localhost:4588/v1/"
  storage_custom_endpoint       = "http://localhost:4588/storage/v1/"
cloud_run_v2_custom_endpoint = "http://localhost:4588/v2/"
}

resource "google_storage_bucket" "project_bucket" {
 name = "devops-gcp-project-bucket"
 location = "us"
}

resource "google_cloud_run_v2_service" "app" {
  name     = "devops-gcp-app"
  location = "us-central1"

  template {
    containers {
      image = "devops-gcp-app:latest"

      ports {
        container_port = 8080
      }
    }
  }
}
