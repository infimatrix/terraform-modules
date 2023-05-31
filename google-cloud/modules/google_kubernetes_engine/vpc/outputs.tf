output "vpc_name" {
  value = google_compute_network.vpc_network.name
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}

output "cluster_secondary_range_name" {
  value = google_compute_subnetwork.subnet.secondary_ip_range[0].range_name
}

output "services_secondary_range_name" {
  value = google_compute_subnetwork.subnet.secondary_ip_range[1].range_name
}