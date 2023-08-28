resource "google_project_service" "compute" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}
resource "google_project_service" "container" {
  project            = var.project_id
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "project" {
  project            = var.project_id
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  auto_create_subnetworks = false
  mtu                     = 1460
  name                    = var.vpc_name
  routing_mode            = var.routing_mode

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

resource "google_compute_subnetwork" "subnet" {
  project                    = var.project_id
  ip_cidr_range              = var.ip_cidr_range
  name                       = var.subnet_name
  network                    = google_compute_network.vpc_network.name
  private_ip_google_access   = var.private_ip_google_access
  private_ipv6_google_access = var.private_ipv6_google_access
  purpose                    = var.purpose
  region                     = var.region
  secondary_ip_range         = var.secondary_ip_ranges
  stack_type = var.stack_type
  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_router" "router" {
  project = var.project_id
  name    = var.router_name
  network = google_compute_network.vpc_network.name
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  project                             = var.project_id
  enable_endpoint_independent_mapping = false
  min_ports_per_vm                    = 64
  name                                = var.nat_gateway_name
  nat_ip_allocate_option              = "AUTO_ONLY"
  nat_ips                             = []
  region                              = var.region
  router                              = google_compute_router.router.name
  source_subnetwork_ip_ranges_to_nat  = var.source_subnetwork_ip_ranges_to_nat

  log_config {
    enable = false
    filter = "ALL"
  }
}


resource "google_compute_firewall" "allow-ingress-from-iap-ssh" {
  name        = var.firewall_name
  network     = google_compute_network.vpc_network.name
  description = var.firewall_description

  allow {
    protocol = var.protocol
    ports    = var.ports
  }

  source_ranges = var.source_ranges

  depends_on = [ google_compute_network.vpc_network ]
}