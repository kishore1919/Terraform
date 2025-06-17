variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "service_account" {
  description = "Service Account email"
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "credentials_file" {
  description = "Path to the GCP service account credentials JSON file"
  type        = string
  default     = null  # Will use GOOGLE_CREDENTIALS env var if not specified
}

variable "regular_min_nodes" {
  description = "Minimum number of nodes in the regular node pool"
  type        = number
  default     = 1
}

variable "regular_max_nodes" {
  description = "Maximum number of nodes in the regular node pool"
  type        = number
  default     = 3
}

variable "gpu_min_nodes" {
  description = "Minimum number of nodes in the GPU node pool"
  type        = number
  default     = 0
}

variable "gpu_max_nodes" {
  description = "Maximum number of nodes in the GPU node pool"
  type        = number
  default     = 2
}

variable "initial_node_count" {
  description = "Initial number of nodes in the cluster"
  type        = number
  default     = 1
}
