resource "aws_lb_target_group" "frontend-load-balancer-tg" {
  name     = "frontend-load-balancer-tg"
  vpc_id   = var.vpc-id
  protocol = "HTTP"
  port     = 80
}

resource "aws_lb_target_group" "backend-load-balancer-tg" {
  name     = "backend-load-balancer-tg"
  vpc_id   = var.vpc-id
  protocol = "HTTP"
  port     = var.backend-port

  health_check {
    path     = "/health"
    protocol = "HTTP"
  }
}
