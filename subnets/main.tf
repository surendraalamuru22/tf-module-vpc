module "lm-subnets" {
  for_each = var.subnets
  source = "./lm-subnets"
  cidr_block = each.value.cidr_block
  vpc_id = var.vpc_id[0]
  name = each.value.name
  env = var.env
  subnet_availability_zones = var.subnet_availability_zones
}

resource "aws_route_table" "route_table" {
  for_each = var.subnets
  vpc_id = var.vpc_id[0]
  tags = {
    Name = "${var.env}-${each.value.name}-rt"
    ENV = var.env
    PROJECT = "roboshop"
  }
}

#output "subnets" {
#  value = module.lm-subnets
#}

output "route-tables" {
  value = aws_route_table.route_table
}