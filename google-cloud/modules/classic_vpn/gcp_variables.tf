variable "project_id" {
  type    = string
  default = "gcp-test-377205"
}

variable "region" {
  type = string
}

### Variables for GCP VPC ####
variable "network_name" {
  type    = string
  default = "gcp-migration-vpc"
}

variable "description" {
  type = string
}

variable "auto_create_subnetworks" {
  type = bool
}

variable "delete_default_routes_on_create" {
  type = bool
}

variable "routing_mode" {
  type = string
}

// Variables for GCP Subnet //
variable "subnet_name" {
  type = string
}

variable "subnet_description" {
  type = string
}

variable "ip_cidr_range" {
  type = string
}

variable "stack_type" {
  type = string
}
variable "purpose" {
  type = string
}

variable "private_ip_google_access" {
  type = bool
}

variable "private_ipv6_google_access" {
  type = string
}

### Variables for Resource GCP Static Compute ADDRESS ####
variable "compute_IP_name" {
  type = string
}

variable "address_type" {
  type = string
}

variable "network_tier" {
  type = string
}

//  Variables for Virtual Private Network and Tunnels //
variable "vpn_gateway_name" {
  type = string
}

variable "tunnel1_name" {
  type = string
}

variable "ike_version" {
}

variable "tunnel2_name" {
  type = string
}