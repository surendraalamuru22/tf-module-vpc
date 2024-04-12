module "lm-subnets" {
  for_each = var.subnets
  source = "./lm-subnets"
  cidr_block = each.value.cidr_block
  vpc_id = var.vpc_id[0]
}