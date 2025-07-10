main-region = "us-east-1"

vpc-cidr = "10.0.0.0/16"

public-subnets = [
  {
    name = "public-subnet-1"
    cidr = "10.0.1.0/24"
    zone = "us-east-1a"
  },
  {
    name = "public-subnet-2"
    cidr = "10.0.2.0/24"
    zone = "us-east-1b"
  },
  {
    name = "public-subnet-3"
    cidr = "10.0.3.0/24"
    zone = "us-east-1c"
  }
]

private-subnets = [
  {
    name = "private-subnet-1"
    cidr = "10.0.4.0/24"
    zone = "us-east-1a"
  },
  {
    name = "private-subnet-2"
    cidr = "10.0.5.0/24"
    zone = "us-east-1c"
  },
  {
    name = "private-subnet-3"
    cidr = "10.0.6.0/24"
    zone = "us-east-1b"
  },
  {
    name = "private-subnet-4"
    cidr = "10.0.7.0/24"
    zone = "us-east-1a"
  },
  {
    name = "private-subnet-5"
    cidr = "10.0.8.0/24"
    zone = "us-east-1c"
  },
  {
    name = "private-subnet-6"
    cidr = "10.0.9.0/24"
    zone = "us-east-1a"
  },
  {
    name = "private-subnet-7"
    cidr = "10.0.10.0/24"
    zone = "us-east-1c"
  }
]

bastion-server-subnet-name       = "public-subnet-1"
nat-gw-subnet-name               = "public-subnet-3"
frontend-lb-subnets-names        = ["public-subnet-1", "public-subnet-2", "public-subnet-3"]
frontend-instances-subnets-names = ["private-subnet-1", "private-subnet-2", "private-subnet-3"]
backend-lb-subnets-names         = ["private-subnet-1", "private-subnet-2", "private-subnet-3"]
backend-instances-subnets-names  = ["private-subnet-4", "private-subnet-5"]
database-subnets-names           = ["private-subnet-6", "private-subnet-7"]

backend-port  = 3000
database-port = 3306
database-name = "my_db"

cloudwatch-alarm-email = "daniahalmosa@gmail.com"
