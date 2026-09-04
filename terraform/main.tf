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

}

resource "google_storage_bucket" "project_bucket" {
 name = "devops-gcp-project-bucket"
 location = "us"
}
