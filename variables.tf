variable "region" {
  description = "region for vpc"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_name" {
  description = "name for vpc"
  type        = string
  default     = "ditme"
}

variable "cidr_block" {
  description = "cidr blocks for vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_public_subnets" {
  description = "list of cidr blocks for public subnets"
  type        = map(string)
  default     = { a = "10.0.11.0/24", b = "10.0.12.0/24", c = "10.0.13.0/24" }
}

variable "cidr_private_subnets" {
  description = "list of cidr blocks for public subnets"
  type        = map(string)
  default     = { a = "10.0.21.0/24", b = "10.0.22.0/24", c = "10.0.23.0/24" }
}

variable "vpc_id" {
  description = "vpc id (if not create new vpc)"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "subnet id (if not create new vpc)"
  type        = list(string)
  default     = []
}
variable "cluster_name" {
  description = "name for cluster"
  type        = string
  default     = "ditme"
}

variable "launch_template_ami_image_id" {
  description = "ami for node"
  type        = string
  default     = "ami-0e3b1f16179593fb8"
}

variable "launch_template_instance_type" {
  description = "instance type for node"
  type        = string
  default     = "t4g.medium"
}

variable "launch_template_key_name" {
  description = "key name for node"
  type        = string
  default     = "t4g.medium"
}

# node
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
