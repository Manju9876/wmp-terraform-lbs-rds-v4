module "database" {
  for_each = var.database
  source   = "./modules/rds"

  component_name = each.key
  allocated_storage = each.value["allocated_storage"]
  env            = var.env
  db_subnets = var.db_subnets
}

module "apps" {
  depends_on = [module.database]
  source = "./modules/component-with-alb"

  dns_domain  = var.dns_domain
  env         = var.env
  vpc_id      = var.vpc_id
  alb_subnets = var.alb_subnets


  for_each                 = var.apps
  component_name           = each.key
  instance_type            = each.value["instance_type"]
  ports                    = each.value["ports"]
  alb                      = each.value["alb"]
  asg                      = each.value["asg"]
  aws_rds_endpoint_address = module.database["postgresql"].aws_rds_endpoint_address
}
