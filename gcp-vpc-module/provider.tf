terraform {
  required_version = ">= 0.13.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.64, < 7.0.0"
    }
  }
}



provider "google" {
  project     = var.project_id
  region      = var.region
}