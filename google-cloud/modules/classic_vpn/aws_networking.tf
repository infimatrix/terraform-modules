### Resource AWS VPC  #####

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = var.vpc_tags
}


### Resource AWS Subnet ######
resource "aws_subnet" "aws-subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone

  tags = var.subnet_tags
}

## Resource AWS Subnet ######
resource "aws_subnet" "aws-subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr_block
  availability_zone = var.availability_zone2

  tags = var.subnet2_tags
}

### Resource AWS Internet Gateway #####
resource "aws_internet_gateway" "aws-vpc-igw" {
  vpc_id = aws_vpc.main.id
  tags   = var.internet_gateway_tags
}

### Resource Customer Gateway ####
resource "aws_customer_gateway" "main" {
  bgp_asn    = var.bgp_asn
  ip_address = google_compute_address.ip_address.address ## The IPv4 address for the customer gateway device's outside interface.(GCP static IP used form vpn or vpn external IP)
  type       = var.gateway_type
  tags       = var.customer_gateway_tags
}

### Resource Virtual Private Gateway ####
resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = aws_vpc.main.id
  tags   = var.virtual_private_gateway_tags
}

### Resource AWS site to site VPN Connection ###
resource "aws_vpn_connection" "aws-vpn-connection" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gw.id
  customer_gateway_id = aws_customer_gateway.main.id
  type                = var.aws_vpn_connection_type //"ipsec.1"
  static_routes_only  = var.static_routes_only
  tags                = var.aws_vpn_connection_tags
}

### resource VPN connection route to add specified range to connect ####
resource "aws_vpn_connection_route" "vpn_route" {
  destination_cidr_block = google_compute_subnetwork.subnetwork1.ip_cidr_range
  vpn_connection_id      = aws_vpn_connection.aws-vpn-connection.id
}

### Resource AWS Route Table ####
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = google_compute_subnetwork.subnetwork1.ip_cidr_range
    gateway_id = aws_vpn_gateway.vpn_gw.id
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-vpc-igw.id
  }
  propagating_vgws = [
    aws_vpn_gateway.vpn_gw.id,
  ]
  tags = var.aws_route_table_tags
}

### Resource AWS Route Table Association  ###
resource "aws_route_table_association" "subnet_association" {
  count          = 2
  subnet_id      = element([aws_subnet.aws-subnet1.id, aws_subnet.aws-subnet2.id], count.index)
  route_table_id = aws_route_table.main.id
}
