resource "aws_security_group" "frontend-load-balancer-sg" {
  vpc_id      = aws_vpc.main-vpc.id
  name        = "frontend-load-balancer-sg"
  description = "Allow HTTP inbound traffic and all outbound taffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "frontend-instances-sg" {
  vpc_id      = aws_vpc.main-vpc.id
  name        = "frontend-instances-sg"
  description = "Allow HTTP inbound traffic and all outbound taffic"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.frontend-load-balancer-sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend-load-balancer-sg" {
  vpc_id      = aws_vpc.main-vpc.id
  name        = "backend-load-balancer-sg"
  description = "Allow backend port inbound traffic and all outbound taffic"

  ingress {
    from_port   = var.backend-port
    to_port     = var.backend-port
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend-instances-sg" {
  vpc_id      = aws_vpc.main-vpc.id
  name        = "backend-instances-sg"
  description = "Allow backend port inbound traffic and all outbound taffic"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.backend-load-balancer-sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds-instances-sg" {
  vpc_id      = aws_vpc.main-vpc.id
  name        = "rds-instances-sg"
  description = "Allow database port inbound traffic and all outbound taffic"

  ingress {
    from_port   = var.database-port
    to_port     = var.database-port
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastion-server-sg" {
  vpc_id      = aws_vpc.main-vpc.id
  name        = "bastion-server-sg"
  description = "Allow SSH inbound traffic and all outbound taffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
