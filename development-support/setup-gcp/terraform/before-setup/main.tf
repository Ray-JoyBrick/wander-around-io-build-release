terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

# variable "private_key_path" {}
# variable "gcs_bucket_name" {}

provider "google" {
  version = "3.5.0"

  # credentials = file("${var.private_key_path}")
  credentials = file("/terraform/keyfile-terraform.json")
  # credentials = "use-terraform.json"

  project = "wander-around-io"
  region  = "us-west1"
  # zone    = "us-central1-c"
}

resource "random_id" "instance_id" {
  byte_length = 8
}

// Use gcloud services list --available to find out which service can be enabled
resource "google_project_service" "service-resource-manager" {
  project = "wander-around-io"
  service = "cloudresourcemanager.googleapis.com"

  # disable_dependent_services = true
  disable_dependent_services = false
}

resource "google_project_service" "service-iam" {
  project = "wander-around-io"
  service = "iam.googleapis.com"

  # disable_dependent_services = true
  disable_dependent_services = false
}

resource "google_project_service" "service-kms" {
  project = "wander-around-io"
  service = "cloudkms.googleapis.com"

  # disable_dependent_services = true
  disable_dependent_services = false
}

resource "google_project_service" "service-cloudapi" {
  project = "wander-around-io"
  service = "cloudapis.googleapis.com"

  # disable_dependent_services = true
  disable_dependent_services = false
}

resource "google_project_service" "service-storage" {
  project = "wander-around-io"
  service = "storage.googleapis.com"

  # disable_dependent_services = true
  disable_dependent_services = false
}

resource "google_project_service" "service-cloudbuild" {
  project = "wander-around-io"
  service = "cloudbuild.googleapis.com"

  # disable_dependent_services = true
  disable_dependent_services = false
}

resource "google_project_service" "service-sourcerepo" {
  project = "wander-around-io"
  service = "sourcerepo.googleapis.com"

  # disable_dependent_services = true
  disable_dependent_services = false
}
