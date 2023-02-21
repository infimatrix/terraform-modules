variable "ip_name" {
  description = "The name of global ip address"
  type        = string
  default     = "sql-private-ip-address"
}

variable "purpose" {
  description = "The purpose of global ip address"
  type        = string
  default     = "VPC_PEERING"
}

variable "prefix_length" {
  description = "The prefix length for the global ip address"
  type        = number
  default     = 16
}

variable "network" {
  description = "The name of VPC used for"
  type        = string
  default     = "default"
}

variable "address_type" {
  description = "The type of address for global ip address"
  type        = string
  default     = "INTERNAL"
}

variable "service" {
  type    = string
  default = "servicenetworking.googleapis.com"
}

variable "master_instance_name" {
  description = "The name of sql database instance."
  type        = string
  default     = "tf-mysql-db-instance"
}

variable "region" {
  description = "The region of the Cloud SQL resources"
  type        = string
  default     = "asia-south1"
}

variable "db_version" {
  description = "The database version to use"
  type        = string
  default     = "MYSQL_8_0"
}

variable "deletion_protection" {
  description = "The deletion protection for sql instance , either true or false"
  type        = bool
  default     = false
}

variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-f1-micro"
}

variable "availability_type" {
  description = "The availability type for the master instance."
  type        = string
  default     = "ZONAL"
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size"
  type        = bool
  default     = false
}

variable "disk_size" {
  description = "The disk size for the master instance"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The disk type for the master instance."
  type        = string
  default     = "PD_SSD"
}

variable "pricing_plan" {
  description = "The pricing plan for the master instance."
  type        = string
  default     = "PER_USE"
}

variable "user_labels" {
  type        = map(string)
  default     = {}
  description = "The key/value labels for the master instances."
}

variable "additional_users" {
  description = "A list of users to be created"
  type = list(object({
    name     = string
    password = string
  }))
  default = []
}


variable "additional_databases" {
  description = "A list of databases to be created"
  type = list(object({
    name      = string
  }))
  default = []
}

variable "maintenance_window_day" {
  description = "The day of week for the master instance maintenance."
  type        = number
  default     = 1
}

variable "maintenance_window_hour" {
  description = "The hour of day maintenance window for the master instance maintenance."
  type        = number
  default     = 23
}

variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance. Can be either `canary` or `stable`."
  type        = string
  default     = "canary"
}

variable "user_name" {
  description = "The name of the default user"
  type        = string
  default     = "root"
}


variable "user_password" {
  description = "The password for the default user"
  type        = string
  default     = "Rahul123"
}

variable "db_name" {
  description = "The name of the default database to create"
  type        = string
  default     = "rahulwp"
}