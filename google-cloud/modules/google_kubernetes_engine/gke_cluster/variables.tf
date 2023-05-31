variable "project_id" {
  description = "Name of the project to be used "
  type        = string
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster (required)"
}

variable "cluster_region" {
  type    = string
  default = "us-central1-c"
}

variable "network" {
  description = "name of the network to be used "
  type        = string
}
variable "subnetwork" {
  description = "Name of the subnetwork to be used"
  type        = string
}

variable "cluster_secondary_range_name" {
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "services_secondary_range_name" {
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