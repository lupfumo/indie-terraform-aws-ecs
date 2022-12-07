/*module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name = "${local.Name} - VPC"
  cidr = var.vpc_cidr_block

  azs              = var.vpc_availability_zones
  private_subnets  = var.vpc_private_subnets
  public_subnets   = var.vpc_public_subnets
  database_subnets = var.vpc_database_subnets

  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  manage_default_security_group = false

  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support


  public_subnet_tags = {
    Application = "Subnets"
    Environment = local.Environment
    Name        = "${local.Name} - public_subnets"
  }

  nat_gateway_tags = {
    Application = "NAT gateway"
    Environment = local.Environment
    Name        = "${local.Name} - NAT Gateway"
  }

  private_subnet_tags = {
    Application = "Subnets"
    Environment = local.Environment
    Name        = "${local.Name} - private_subnets"
  }

  database_subnet_tags = {
    Application = "Subnets"
    Environment = local.Environment
    Name        = "${local.Name} - database_subnets"
  }
}
*/
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name = "${local.name}-vpc"
  cidr = var.vpc_cidr_block

  azs             = var.vpc_availability_zones
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  #Database subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  database_subnets                   = var.vpc_database_subnets

  #NAT Gateway for Outbound communications
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  #VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Type = "${local.name}-public Subnets"
  }
  private_subnet_tags = {
    Type = "${local.name}-private Subnets"
  }
  database_subnet_tags = {
    Type = "${local.name}-database Subnets"
  }
  tags = local.common_tags
}
