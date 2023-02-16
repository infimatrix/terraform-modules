variable "secret_id" {
  description = "The Name of secret manager"
  type = string
}

variable "labels" {
  description = "The labels to be used on secret manager"
  type = map(string)
}

variable "replication" {
  description = "The Secret will automatically be replicated without any restrictions"
  type = bool
  default = true
}


variable "secret_data" {
  description = "The secret data which we want to store in secret manager"
  type = map
  default = {
    version1 = "data1"
    version2 = "data2"
  }
}