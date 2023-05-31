output "cluster_id" {
  description = "Cluster ID"
  value       = google_container_cluster.primary.id
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_location" {
  value = google_container_cluster.primary.location
}