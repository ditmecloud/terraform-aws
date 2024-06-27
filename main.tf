locals {
  create_vpc = var.vpc_id == ""
  vpc_id     = local.create_vpc ? module.vpc[0].vpc_id : var.vpc_id
  subnet_ids = local.create_vpc ? module.vpc[0].private_subnet_ids : var.subnet_ids
}

module "vpc" {
  count = var.vpc_id == "" ? 1 : 0

  source               = "./modules/vpc"
  region               = var.region
  vpc_name             = var.vpc_name
  cidr_block           = var.cidr_block
  cidr_public_subnets  = var.cidr_public_subnets
  cidr_private_subnets = var.cidr_private_subnets
  cluster_name         = var.cluster_name
}

module "eks" {
  source                        = "./modules/eks"
  region                        = var.region
  cluster_name                  = var.cluster_name
  vpc_id                        = local.vpc_id
  cidr_block                    = var.cidr_block
  subnet_ids                    = local.subnet_ids
  launch_template_ami_image_id  = var.launch_template_ami_image_id
  launch_template_instance_type = var.launch_template_instance_type
  launch_template_key_name      = var.launch_template_key_name
  desired_size                  = var.desired_size
  max_size                      = var.max_size
  min_size                      = var.min_size
  depends_on = [module.vpc]
}