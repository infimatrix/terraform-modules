locals {
  enable_autoscaling = var.enable_autoscaling ? [true] : []
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

resource "google_container_cluster" "primary" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.cluster_region

  network         = google_compute_network.vpc_network.name
  subnetwork      = google_compute_subnetwork.subnet.name
  resource_labels = var.cluster_resource_labels

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.

  initial_node_count       = var.initial_node_count
  remove_default_node_pool = var.remove_default_node_pool

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.subnet.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.subnet.secondary_ip_range[1].range_name
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.authorized_cidr_blocks
      display_name = var.display_names
    }
  }
  workload_identity_config {
  //workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
}

  # master_authorized_networks_config {
  #   for_each = toset(var.authorized_cidr_blocks)
  #   cidr_blocks {
  #     cidr_block   = each.key
  #     display_name = var.display_names[index(var.authorized_cidr_blocks, each.key)]
  #   }
  # }
  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = var.enable_autoscaling ? null : var.node_count

  dynamic "autoscaling" {
    for_each = local.enable_autoscaling
    content {
      min_node_count = var.min_node_count
      max_node_count = var.max_node_count
    }
  }


  node_config {
    image_type      = var.image_type
    machine_type    = var.machine_type
    disk_size_gb    = var.disk_size_gb
    disk_type       = var.disk_type
    local_ssd_count = var.local_ssd_count
    preemptible     = var.preemptible
    //service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = var.node_labels
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}