# GKE Cluster Outputs
output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "The endpoint for the GKE cluster"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_master_version" {
  description = "The master version of the GKE cluster"
  value       = google_container_cluster.primary.master_version
}

output "cluster_connect_url" {
  description = "The connection URL for the GKE cluster"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --region ${google_container_cluster.primary.location} --project ${google_container_cluster.primary.project}"
}
