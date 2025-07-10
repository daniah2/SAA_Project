resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = var.database-subnets-ids
}

resource "aws_db_instance" "db" {
  allocated_storage      = 10
  db_name                = var.database-name
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.database-username
  password               = var.database-password
  publicly_accessible    = false
  multi_az               = true
  vpc_security_group_ids = [var.database-sg-id]
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  skip_final_snapshot    = true
}
