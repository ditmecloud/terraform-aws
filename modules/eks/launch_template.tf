## launch template
resource "aws_launch_template" "eks_launch_template" {
  name          = "${var.cluster_name}-node"
  image_id      = var.launch_template_ami_image_id
  instance_type = var.launch_template_instance_type
  key_name      = var.launch_template_key_name

  user_data = base64encode(<<-EOF
    #!/bin/bash
    /etc/eks/bootstrap.sh ${var.cluster_name}
  EOF
  )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp3"
    }
  }
  
  network_interfaces {
    security_groups = [aws_security_group.eks_security_group_node.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "${var.cluster_name}-node"
      Project = var.cluster_name
    }
  }
}
