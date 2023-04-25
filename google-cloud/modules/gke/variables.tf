variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in (required)"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster (required)"
}

variable "location" {
  type        = string
  description = "The location to host the cluster in (zonal/regional)"
  default     = null
}

variable "network" {
  type        = string
  description = "The VPC network to host the cluster in (required)"
}


variable "subnetwork" {
  type        = string
  description = "The subnetwork to host the cluster in (required)"
}

variable "ip_range_pods" {
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "ip_range_services" {
  type        = string
  description = "The _name_ of the secondary subnet range to use for services"
}

variable "initial_node_count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
  default     = 1
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Remove default node pool while setting up the cluster"
  default     = true
}

variable "cluster_resource_labels" {
  type        = map(string)
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  default     = {}
}

variable "enable_private_nodes" {
  type        = bool
  description = "If set to true, Enables the private cluster feature, creating a private endpoint on the cluster"
}

variable "enable_private_endpoint" {
  type        = bool
  description = "When true, the cluster's private endpoint is used as the cluster endpoint and access through the public endpoint is disabled. When false, either endpoint can be used. This field only applies to private clusters, when enable_private_nodes is true"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP"
}

variable "authorized_cidr_blocks" {
  type        = string
  description = "The authorized cidr block to connect to private cluster"
}

variable "display_names" {
  type        = string
  description = "The display name for cidr_blocks users"
}

variable "enable_autoscaling" {
  default = false
}

variable "node_count" {
  default = "1"
}

variable "min_node_count" {
  default = "1"
}
variable "max_node_count" {
  default = "3"
}

variable "image_type" {
  default = "COS"
}

variable "machine_type" {
  default = "n1-standard-1"
}
variable "local_ssd_count" {
  default = "0"
}

variable "disk_size_gb" {
  default = "100"
}

variable "disk_type" {
  default = "pd-standard"
}
variable "service_account" {
  type = string
}

variable "preemptible" {
  default = "false"
}

variable "node_labels" {
  type        = map(string)
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the node"
  default     = {}
}