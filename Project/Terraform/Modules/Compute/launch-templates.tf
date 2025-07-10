resource "aws_launch_template" "frontend-launch-template" {
  name = "frontend-launch-template"

  disable_api_termination = false
  ebs_optimized           = true

  image_id                             = "ami-0a7d80731ae1b2435"
  instance_initiated_shutdown_behavior = "terminate"
  instance_market_options { market_type = "spot" }
  instance_type = "t3.micro"

  key_name = aws_key_pair.ssh-public-key.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.compute-workloads.frontend-instances.sg-id]
  }

  update_default_version = true
  user_data = base64encode(templatefile("./Modules/Compute/frontend-startup.sh", {
    BACKEND_LB_DNS  = aws_lb.backend-lb.dns_name
    BACKEND_LB_PORT = var.backend-port
  }))
}

resource "aws_launch_template" "backend-launch-template" {
  name = "backend-launch-template"

  disable_api_termination = false
  ebs_optimized           = true

  image_id                             = "ami-0a7d80731ae1b2435"
  instance_initiated_shutdown_behavior = "terminate"
  instance_market_options { market_type = "spot" }
  instance_type = "t3.micro"

  key_name = aws_key_pair.ssh-public-key.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.compute-workloads.backend-instances.sg-id]
  }

  update_default_version = true
  user_data              = base64encode(templatefile("./Modules/Compute/backend-startup.sh", { DATABASE_HOSTNAME = var.database-hostname }))
  iam_instance_profile { name = aws_iam_instance_profile.ec2-read-only-profile.name }
}

resource "aws_iam_instance_profile" "ec2-read-only-profile" {
  name = "ec2-read-only-profile"
  role = var.secrets-ssm-read-only-role-name
}
