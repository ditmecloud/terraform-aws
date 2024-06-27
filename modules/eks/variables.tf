variable "region" {}
variable "cluster_name" {}

variable "vpc_id" {}
variable "cidr_block" {}
variable "subnet_ids" {}

## launch template
variable "launch_template_ami_image_id" {}
variable "launch_template_instance_type" {}
variable "launch_template_key_name" {}

# node
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}

