module "lm-subnets" {
  for_each = var.subnets
  source = "./lm-subnets"
  cidr_block = each.value.cidr_block
  vpc_id = var.vpc_id[0]
  name = each.value.name
  env = var.env
  subnet_availability_zones = var.subnet_availability_zones
  route_table_id = lookup(lookup(aws_route_table.aws-route-table, each.value.name, null), "id", null)
}

resource "aws_route_table" "aws-route-table" {
  for_each = var.subnets
  vpc_id = var.vpc_id[0]
  tags = {
    Name = "${var.env}-${each.value.name}-rt"
    ENV = var.env
    PROJECT = "roboshop"
  }
}
#
#output "subnets" {
#  value = module.lm-subnets
#}
#
#output "route-table" {
#  value = aws_route_table.aws-route-table
#}


resource "aws_route" "peering-connection-route" {
  for_each = var.subnets
  route_table_id            = lookup(lookup(aws_route_table.aws-route-table, each.value.name, null), "id", null)
  destination_cidr_block    = lookup(var.management_vpc, "cidr_block", null)
  vpc_peering_connection_id = var.peering_connection_id
}

resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.aws-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gateway_id
}
