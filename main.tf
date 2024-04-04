resource "aws_vpc" "main" {
  for_each = var.vpc
  cidr_block = each.value.cidr_block
  tags = local.vpc_tags
}

module "additional_cidr_block" {
  count = var.vpc
  source = "./additional_vpc_cidr"
  additional_cidr_block = each.value.additional_cidr_block
  vpc_id = aws_vpc.main.id
}