locals {
  enable_autoscaling = var.enable_autoscaling ? [true] : []
}

resource "google_container_node_pool" "primary_nodes" {
  # name       = data.terraform_remote_state.gke_cluster.outputs.cluster_name
  # location   = data.terraform_remote_state.gke_cluster.outputs.cluster_location
  # cluster    = data.terraform_remote_state.gke_cluster.outputs.cluster_name
  name       = var.node_pool_name
  location   = var.node_location
  cluster    = var.cluster_name
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
    service_account = var.service_account
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