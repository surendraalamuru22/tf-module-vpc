resource "aws_vpc" "main" {
  for_each = var.vpc
  cidr_block = each.value.cidr_block
}

module "additional_vpc_cidr" {
  for_each = var.vpc
  env = var.env
  source = "./additional_vpc_cidr"
  additional_cidr_block = each.value.additional_cidr_block
  vpc_id = [for k, v in aws_vpc.main : v.id]
}