module "ec2-module" {
  source = "./module/ec2-instance"
  ec2-variable = var.ec2-tfvars
}

module "ec2-vpc" {
  source = "./module/vpc"
  ec2-vpc = var.vpc-tfvars
}

module "ec2-subnet" {
  source = "./module/subnet"
  aws-subnet = var.subnet-tfvars
  vpc_id = module.ec2-vpc.vpc_output
}