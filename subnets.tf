module "public_subnets" {
  for_each = var.vpc
  source = "./subnets"
  subnets = each.value.public_subnets
  vpc_id = [for k, v in aws_vpc.main : v.id]
  env = var.env
  subnet_availability_zones = each.value.subnet_availability_zones
  peering_connection_id = aws_vpc_peering_connection.management-vpc-to-dev-vpc.*.id[0]
  management_vpc = var.management_vpc
  gateway_id                = aws_internet_gateway.igw.id
}


module "private_subnets" {
  for_each = var.vpc
  source = "./subnets"
  subnets = each.value.private_subnets
  vpc_id = [for k, v in aws_vpc.main : v.id]
  env = var.env
  subnet_availability_zones = each.value.subnet_availability_zones
  peering_connection_id = aws_vpc_peering_connection.management-vpc-to-dev-vpc.*.id[0]
  management_vpc = var.management_vpc
  gateway_id                = aws_nat_gateway.ngw.id
}