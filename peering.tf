resource "aws_vpc_peering_connection" "management_vpc_to_dev_vpc" {
  count = length(local.vpc_ids)
  peer_vpc_id   = lookup(var.management_vpc, "vpc_id", null)
  vpc_id        = element(local.vpc_ids, count.index)
  auto_accept = true
  tags = local.vpc_peering_tags
}