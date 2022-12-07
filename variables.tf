variable "domain_name" {
  description = "The allowed host name."
  type        = string
  default     = "tfecsimage-alb-1719788996.us-east-1.elb.amazonaws.com"
}

variable "aws_region" {
  default     = "af-south-1"
  description = "The required region needed."
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_availability_zones" {
  description = "VPC Availability zones"
  type        = list(string)
  default     = ["af-south-1a", "af-south-1b"]
}

variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.0.31.0/24", "10.0.32.0/24"]
}

variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group "
  type        = bool
  default     = true
}

variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type        = bool
  default     = true
}

variable "vpc_enable_nat_gateway" {
  description = "VPC Enable NAT Gateway"
  type        = bool
  default     = true
}

variable "vpc_single_nat_gateway" {
  description = "VPC Single NAT Gateway"
  type        = bool
  default     = true
}

variable "port_app" {
  default     = "80"
  description = "Access via Port 80"
}

variable "container_count" {
  default     = "4"
  description = "Number of task running in a container."
}

variable "fargate_cpu" {
  default     = "1024"
  description = "CPU for the fargate ecs"
}

variable "fargate_memory" {
  default     = "2048"
  description = "Memory for the fargate ecs"

}
variable "ecs_task_execution_role" {
  default     = "IndieEcsTaskExecutionRole"
  description = "ECS task execution role name"
}

variable "source_path" {
  description = "source path for project"
  default     = "./"
}

variable "database_instance" {
  description = "database instance type"
  default     = "db.t2.micro"
  type        = string
}

variable "database_instance_identifier" {
  description = "database instance identifier"
  type        = string
  default     = "mysql57db"
}

variable "local-environment" {
  description = "The name of the environment"
  type        = string
  default     = "dev"
}

variable "business_division" {
  description = "The name of the division."
  type        = string
  default     = "platform"
}

variable "db_username" {
  type    = string
  default = "admin"
  //sensitive = true
}

variable "db_password" {
  type    = string
  default = "Pipeline11*"
  //sensitive = true
}

variable "environment" {
  //type = object({
  //inputs = map(string)
  //default = string

}