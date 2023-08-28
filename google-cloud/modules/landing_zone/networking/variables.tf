variable "project_id" {
  type = string
}
variable "region" {
  type    = string
  default = "asia-south1"
}

variable "vpc_name" {
  type    = string
  default = "mantis-test-vpc-2"
}

variable "auto_create_subnetworks" {
  type    = bool
  default = false
}

variable "delete_default_routes_on_create" {
  type    = bool
  default = true
}

variable "routing_mode" {
  type    = string
  default = "REGIONAL"
}

variable "subnet_name" {
  type    = string
  default = "mantis-test-subnet-as-st1-2"
}

variable "ip_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}


variable "private_ip_google_access" {
  type    = bool
  default = true
}


variable "private_ipv6_google_access" {
  type    = string
  default = "DISABLE_GOOGLE_ACCESS"
}

variable "stack_type" {
  type    = string
  default = "IPV4_ONLY"
}

variable "purpose" {
  type    = string
  default = "PRIVATE"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  type    = string
  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "secondary_ip_ranges" {
  description = "A list of secondary IP ranges to be associated with the subnetwork."
  type = list(object({
    ip_cidr_range = string
    range_name    = string
  }))
  default = [
    {
      ip_cidr_range = "10.11.0.0/21"
      range_name    = "gke-cluster-pod-range-2"
    },
    {
      ip_cidr_range = "10.12.0.0/21"
      range_name    = "gke-cluster-svc-range-2"
    },
  ]
}

variable "router_name" {
  type    = string
  default = "as-st2-test-router"
}

variable "nat_gateway_name" {
  type    = string
  default = "as-st2-test-gw"
}

variable "firewall_name" {
  type    = string
  default = "allow-ingress-from-iap-ssh"
}

variable "firewall_description" {
  type    = string
  default = "Creates firewall rule to access vm using ssh"
}

variable "protocol" {
  type    = string
  default = "tcp"
}

variable "ports" {
  type    = list(string)
  default = ["22", "3389"]
}

variable "source_ranges" {
  type    = list(string)
  default = ["35.235.240.0/20"]
}