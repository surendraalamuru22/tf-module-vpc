module "subnets" {
  for_each = var.vpc
  env = var.env
  source = "./subnets"
  subnets = each.value.subnets
  vpc_id = [for k, v in aws_vpc.main : v.id]
}