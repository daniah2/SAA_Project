resource "aws_autoscaling_group" "frontend-autoscaling-group" {
  vpc_zone_identifier = var.compute-workloads.frontend-instances.subnets-ids
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1

  launch_template {
    id      = aws_launch_template.frontend-launch-template.id
    version = aws_launch_template.frontend-launch-template.latest_version
  }

  target_group_arns = [aws_lb_target_group.frontend-load-balancer-tg.arn]
}

resource "aws_autoscaling_group" "backend-autoscaling-group" {
  vpc_zone_identifier = var.compute-workloads.backend-instances.subnets-ids
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1

  launch_template {
    id      = aws_launch_template.backend-launch-template.id
    version = aws_launch_template.backend-launch-template.latest_version
  }

  target_group_arns = [aws_lb_target_group.backend-load-balancer-tg.arn]
}
