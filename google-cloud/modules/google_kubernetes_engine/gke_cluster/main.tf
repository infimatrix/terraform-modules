resource "google_container_cluster" "primary" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.cluster_region

  //network         = google_compute_network.vpc_network.name
  //network = data.terraform_remote_state.vpc.outputs.vpc_name
  network = var.network
  //subnetwork      = google_compute_subnetwork.subnet.name
  //subnetwork = data.terraform_remote_state.vpc.outputs.subnet_name
  subnetwork      = var.subnetwork
  resource_labels = var.cluster_resource_labels

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.

  initial_node_count       = var.initial_node_count
  remove_default_node_pool = var.remove_default_node_pool

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }
  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
}