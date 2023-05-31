variable "enable_autoscaling" {
  default = false
}
variable "node_pool_name" {
  type = string
}

variable "node_location" {
  type = string
}

variable "cluster_name" {
  type = string
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