output "subnets" {
  value = module.subnets
}

output "route_tables" {
  value = module.subnets.route-tables
}