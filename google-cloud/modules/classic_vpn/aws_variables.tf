variable "access_key" {
  type    = string
  default = "AKIAYHNAJUPOHMWO7TV4"

}

variable "secret_key" {
  type    = string
  default = "RnshGr2TnnwTcpUeC6f6myuwxSgv5IJonLSxldHU"
}

// Variables for AWS VPC //
variable "vpc_cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "vpc_tags" {
  type = map(string)
}

// Variables for AWS Subnet  //
variable "subnet_cidr_block" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "subnet_tags" {
  type = map(string)
}

variable "subnet2_cidr_block" {
  type = string
}

variable "availability_zone2" {
  type = string
}

variable "subnet2_tags" {
  type = map(string)
}

variable "internet_gateway_tags" {
  type = map(string)
}

variable "bgp_asn" {
}

variable "gateway_type" {
  type = string
}

variable "customer_gateway_tags" {
  type = map(string)
}

variable "virtual_private_gateway_tags" {
  type = map(string)
}

variable "aws_vpn_connection_type" {
  type = string
}

variable "aws_vpn_connection_tags" {
  type = map(string)
}
variable "static_routes_only" {
  type = bool
}

variable "aws_route_table_tags" {
  type = map(string)
}