terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.58.0"
    }
  }
}

provider "google" {
  credentials = file("../google-key.json")
  project     = var.project_id
  region      = "us-central1"
}