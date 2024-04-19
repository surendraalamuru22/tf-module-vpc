resource "aws_vpc_peering_connection" "management-vpc-to-dev-vpc" {
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = lookup(var.management_vpc, "vpc_id", null)
  auto_accept = true
  tags = local.vpc_peering_tags
}

#
#resource "aws_route" "route-to-default-management-route-table" {
#  for_each = var.vpc
#  route_table_id            = lookup(var.management_vpc, "route_table_id", null)
#  destination_cidr_block    = each.value.cidr_block
#  vpc_peering_connection_id = aws_vpc_peering_connection.management-vpc-to-dev-vpc.*.id[0]
#}