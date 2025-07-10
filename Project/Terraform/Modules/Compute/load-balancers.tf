resource "aws_lb" "frontend-lb" {
  internal           = false
  name               = "frontend-lb"
  load_balancer_type = "application"
  security_groups    = [var.compute-workloads.frontend-lb.sg-id]
  subnets            = var.compute-workloads.frontend-lb.subnets-ids
}

resource "aws_lb" "backend-lb" {
  internal           = true
  name               = "backend-lb"
  load_balancer_type = "application"
  security_groups    = [var.compute-workloads.backend-lb.sg-id]
  subnets            = var.compute-workloads.backend-lb.subnets-ids
}

resource "aws_lb_listener" "frontend-listener" {
  load_balancer_arn = aws_lb.frontend-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-load-balancer-tg.arn
  }
}

resource "aws_lb_listener" "backend-listener" {
  load_balancer_arn = aws_lb.backend-lb.arn
  port              = var.backend-port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-load-balancer-tg.arn
  }
}
