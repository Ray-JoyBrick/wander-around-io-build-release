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

resource "google_service_account" "use-kms" {
  account_id = "use-kms"
  display_name = "Service Account"
}

resource "google_service_account" "use-storage" {
  account_id = "use-storage"
  display_name = "Service Account"
}

# Assume it is from top to bottom
resource "null_resource" "before" {
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 30"
  }
  triggers = {
    "before" = "${null_resource.before.id}"
  }
}

resource "null_resource" "after" {
  depends_on = [null_resource.delay]
}

# These two role assigning don't succeed for some reason
resource "google_project_iam_binding" "sa-use-kms" {
  project = "wander-around-io"
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:${google_service_account.use-kms.email}",
  ]
}

resource "google_project_iam_binding" "sa-use-storage" {
  project = "wander-around-io"
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.use-storage.email}",
  ]
}

# Don't uncomment this
# resource "google_service_account_iam_binding" "use-kms-iam" {
#   service_account_id = "${google_service_account.use-kms.name}"
#   # role = "projects/wander-around-io/roles/cloudkms.cryptoKeyEncrypterDecrypter"
#   role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

#   members = [
#     "serviceAccount:${google_service_account.use-kms.email}"
#   ]
# }

# Don't uncomment this
# resource "google_service_account_iam_member" "use-kms-iam" {
#   service_account_id = "${google_service_account.use-kms.name}"
#   role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#   member = "serviceAccount:${google_service_account.use-kms.email}"
# }

# Need to enable API
resource "google_sourcerepo_repository" "ucb-build-release" {
  name = "ucb-build-release"
}

resource "google_sourcerepo_repository" "ucb-build-asset" {
  name = "ucb-build-asset"
}

resource "google_storage_bucket" "joybrick-wander-around-io-dev" {
  name = "joybrick-wander-around-io-dev"
  location = "us-west1"
  storage_class = "STANDARD"
}

# Need to enable API
resource "google_cloudbuild_trigger" "trigger-build-release" {
  name = "trigger-build-release"

  description = "Build release version"

  trigger_template {
    branch_name = "^prepare-build-release$"
    repo_name   = "ucb-build-release"
  }

  # tags = ["build"]

  substitutions = {
    _GCS_BUCKET = "joybrick-wander-around-io-dev"
  }

  filename = "cloudbuild-build-release.yaml"
}

resource "google_cloudbuild_trigger" "trigger-build-asset" {
  name = "trigger-build-asset"

  description = "Build asset version"

  trigger_template {
    branch_name = "^prepare-build-asset$"
    repo_name   = "ucb-build-asset"
  }

  # tags = ["build"]

  substitutions = {
    _GCS_BUCKET = "joybrick-wander-around-io-dev"
  }

  filename = "cloudbuild-build-asset.yaml"
}
