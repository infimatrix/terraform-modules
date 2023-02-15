variable "secret_id" {
  type = string
}

variable "labels" {
  type = map(string)
}

variable "replication" {
  type = bool
  default = true
}

variable "secret_data" {
  type = string
}

variable "secret_data2" {
  type = string
}