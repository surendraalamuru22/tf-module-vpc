module "lm-subnets" {
  for_each = var.subnets
  source = "./lm-subnets"
  cidr_block = each.value.cidr_block
  vpc_id = var.vpc_id[0]
  name = each.value.name
  env = var.env
  subnet_availability_zones = var.subnet_availability_zones
  route_table_id = lookup(lookup(aws_route_table.aws_route_table, each.value.name, null), "id", null)
}

resource "aws_route_table" "aws_route_table" {
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
  value = aws_route_table.aws_route_table
}

output "id" {
  value = lookup(lookup(aws_route_table.aws_route_table, each.value.name, null), "id", null)
}