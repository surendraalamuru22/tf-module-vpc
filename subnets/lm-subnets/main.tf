resource "aws_subnet" "main" {
  count = length(var.cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = element(var.cidr_block, count.index)
  tags = local.subnet_tags
  availability_zone = element(var.subnet_availability_zones, count.index)
}

resource "aws_route_table_association" "route_table_association" {
  count = length(aws_subnet.main)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = var.route_table_id
}

output "subnets" {
  value = aws_subnet.main
}