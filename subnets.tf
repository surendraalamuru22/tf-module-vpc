module "public_subnets" {
  for_each = var.public_subnets
  cidr_block = each.value.cidr_block
  name = each.value.name
  source = "./subnets"
  subnets = var.public_subnets
  vpc_id = aws_vpc.main.id
  env = var.env
  subnet_availability_zones = var.subnet_availability_zones
  gateway_id = aws_internet_gateway.igw.id
#  peering_connection_id = aws_vpc_peering_connection.management-vpc-to-dev-vpc.*.id[0]
#  management_vpc = var.management_vpc
}


module "private_subnets" {
  for_each = var.private_subnets
  source = "./subnets"
  subnets = var.private_subnets
  cidr_block = each.value.cidr_block
  name = each.value.name
  vpc_id = aws_vpc.main.id
  env = var.env
  subnet_availability_zones = var.subnet_availability_zones
  gateway_id = aws_nat_gateway.ngw.id
#  peering_connection_id = aws_vpc_peering_connection.management-vpc-to-dev-vpc.*.id[0]
#  management_vpc = var.management_vpc
}