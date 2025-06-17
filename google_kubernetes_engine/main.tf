terraform {
   required_providers {
     google = {
       source  = "hashicorp/google"
       version = ">= 5.25.0"
     }
   }
 }

provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file(var.credentials_file)
}


# Regular worker node pool
resource "google_container_node_pool" "regular_workers" {
  name       = "regular-worker-pool"
  location   = "${var.region}-a"
  cluster    = google_container_cluster.primary.name

  autoscaling {
    min_node_count = var.regular_min_nodes
    max_node_count = var.regular_max_nodes
  }

  node_config {
    machine_type = "e2-standard-4"  # 4 vCPU, 16GB memory

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# GPU worker node pool with T4
resource "google_container_node_pool" "gpu_workers" {
  name       = "gpu-worker-pool"
  location   = "${var.region}-a"  # Specific zone instead of region
  cluster    = google_container_cluster.primary.name

  autoscaling {
    min_node_count = var.gpu_min_nodes
    max_node_count = var.gpu_max_nodes
  }

  node_config {
    machine_type = "n1-standard-4"  # 4 vCPU, 16GB memory

    guest_accelerator {
      type  = "nvidia-tesla-t4"
      count = 1
      
      gpu_driver_installation_config {
        gpu_driver_version = "DEFAULT"
      }

      gpu_sharing_config {
        gpu_sharing_strategy = "TIME_SHARING"
        max_shared_clients_per_gpu = 2
      }
    }

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    # Install GPU drivers automatically
    metadata = {
      "install-nvidia-driver" = "true"
    }

    # Add GPU-specific labels
    labels = {
      "cloud.google.com/gke-accelerator" = "nvidia-tesla-t4"
      "gpu-node"                         = "true"
    }

    # Add taint to ensure only GPU workloads are scheduled
    taint {
      key    = "nvidia.com/gpu"
      value  = "present"
      effect = "NO_SCHEDULE"
    }

    # Enable GPU sharing
    kubelet_config {
      cpu_manager_policy = "static"
      cpu_cfs_quota     = true
    }
  }
}


resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = "${var.region}-a"  # Specific zone instead of region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  # Enable Workload Identity
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  deletion_protection = false
}