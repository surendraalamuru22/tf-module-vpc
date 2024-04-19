module "public_subnets" {
  for_each = var.public_subnets
  cidr_block = each.value.cidr_block
  name = each.value.name
  source = "./subnets"
  subnets = var.public_subnets
  vpc_id = aws_vpc.main.id
  env = var.env
  subnet_availability_zones = var.subnet_availability_zones
#  peering_connection_id = aws_vpc_peering_connection.management-vpc-to-dev-vpc.*.id[0]
#  management_vpc = var.management_vpc
}

#
#module "private_subnets" {
#  for_each = var.vpc
#  source = "./subnets"
#  subnets = each.value.private_subnets
#  vpc_id = [for k, v in aws_vpc.main : v.id]
#  env = var.env
#  subnet_availability_zones = each.value.subnet_availability_zones
#  peering_connection_id = aws_vpc_peering_connection.management-vpc-to-dev-vpc.*.id[0]
#  management_vpc = var.management_vpc
#}