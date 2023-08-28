### Resource GCP VPC ###
resource "google_compute_network" "vpc_network" {
  project                         = var.project_id
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = var.delete_default_routes_on_create
  description                     = var.description
  name                            = var.network_name
  routing_mode                    = var.routing_mode
}

# resource "google_compute_subnetwork" "subnetwork" {
#   project                    = var.project_id
#   //for_each                   = var.subnets
#   for_each = { for subnetwork in var.subnets : subnetwork.name => subnetwork }
#   name                       = each.key
#   ip_cidr_range              = each.value.ip_cidr_range
#   description                = each.value.description
#   private_ip_google_access   = each.value.private_ip_google_access
#   private_ipv6_google_access = each.value.private_ipv6_google_access
#   purpose                    = each.value.purpose
#   stack_type                 = each.value.stack_type
#   region                     = each.value.region
#   network                    = google_compute_network.vpc_network.id
#   secondary_ip_range         = each.value.secondary_ip_range
# }

### Resource GCP Subnet ####
resource "google_compute_subnetwork" "subnetwork1" {
  project                    = var.project_id
  name                       = var.subnet_name
  description                = var.subnet_description
  ip_cidr_range              = var.ip_cidr_range
  network                    = google_compute_network.vpc_network.id
  private_ip_google_access   = var.private_ip_google_access
  private_ipv6_google_access = var.private_ipv6_google_access
  purpose                    = var.purpose
  region                     = var.region
  stack_type                 = var.stack_type
}


# ### Resource GCP Subnet ####
# resource "google_compute_subnetwork" "subnetwork2" {
#   ip_cidr_range              = "192.168.1.0/24"
#   name                       = "subnet-2"
#   network                    = google_compute_network.vpc_network.id
#   private_ip_google_access   = true
#   private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
#   project                    = "gcp-test-377205"
#   purpose                    = "PRIVATE"
#   region                     = "us-central1"
#   secondary_ip_range = [
#     {
#       ip_cidr_range = "10.192.0.0/20"
#       range_name    = "gke-cluster-1-services-33c17429"
#     },
#     {
#       ip_cidr_range = "10.188.0.0/14"
#       range_name    = "gke-cluster-1-pods-33c17429"
#     },
#   ]
#   stack_type = "IPV4_ONLY"
# }


### Resource GCP Static Compute ADDRESS ####
resource "google_compute_address" "ip_address" {
  project = var.project_id

  address_type = var.address_type
  name         = var.compute_IP_name
  network_tier = var.network_tier
  region       = var.region
}


### Resource GCP Virtual Private Network Gateway ###
resource "google_compute_vpn_gateway" "target_gateway" {
  project = var.project_id
  name    = var.vpn_gateway_name
  network = google_compute_network.vpc_network.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "fr-esp"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.ip_address.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.ip_address.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.ip_address.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

### Resource GCP Virtual Private Network Tunnel ###
resource "google_compute_vpn_tunnel" "tunnel1" {
  project     = var.project_id
  ike_version = var.ike_version
  local_traffic_selector = [
    aws_vpc.main.cidr_block,
  ]
  name    = var.tunnel1_name
  peer_ip = aws_vpn_connection.aws-vpn-connection.tunnel1_address
  region  = var.region
  remote_traffic_selector = [
    "0.0.0.0/0",
  ]
  shared_secret      = aws_vpn_connection.aws-vpn-connection.tunnel1_preshared_key
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway.id

  depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]

}


### Resource GCP Virtual Private Network Tunnel ###
resource "google_compute_vpn_tunnel" "tunnel2" {
  project     = var.project_id
  ike_version = var.ike_version
  local_traffic_selector = [
    aws_vpc.main.cidr_block,
  ]
  name    = var.tunnel2_name
  peer_ip = aws_vpn_connection.aws-vpn-connection.tunnel2_address
  region  = var.region
  remote_traffic_selector = [
    "0.0.0.0/0",
  ]
  shared_secret      = aws_vpn_connection.aws-vpn-connection.tunnel2_preshared_key
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway.id
  depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]
}

