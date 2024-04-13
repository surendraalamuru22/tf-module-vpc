locals {
  id = lookup(lookup(aws_route_table.aws_route_table, each.value.name, null), "id", null)
}