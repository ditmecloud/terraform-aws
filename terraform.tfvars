region = "ap-southeast-1"

vpc_name             = "xxxx"
cidr_block           = "10.0.0.0/16"
cidr_public_subnets  = { a = "10.0.11.0/24", b = "10.0.12.0/24", c = "10.0.13.0/24" }
cidr_private_subnets = { a = "10.0.21.0/24", b = "10.0.22.0/24", c = "10.0.23.0/24" }

## if not create new vpc
vpc_id     = ""
subnet_ids = []

cluster_name = "xxxx"

launch_template_ami_image_id  = "ami-0e3b1f16179593fb8"
launch_template_instance_type = "t4g.medium"
launch_template_key_name      = "xxxx"

desired_size                  = 2
max_size                      = 3
min_size                      = 1
