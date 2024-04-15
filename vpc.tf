resource "aws_vpc" "main" {
  for_each = var.vpc
  cidr_block = each.value.cidr_block
  tags = local.vpc_tags
}

module "additional_vpc_cidr" {
  for_each = var.vpc
  source = "./additional_vpc_cidr"
  additional_cidr_block = each.value.additional_cidr_block
  vpc_id = [for k, v in aws_vpc.main : v.id]
}

#output "vpc" {
#  value = aws_vpc.main
#}

#output "vpc" {
#  value = [for k, v in aws_vpc.main : v.id]
#}