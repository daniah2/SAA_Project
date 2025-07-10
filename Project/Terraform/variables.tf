variable "main-region" {
  type = string
}

variable "vpc-cidr" {
  type = string
}

variable "public-subnets" {
  type = list(object({
    name = string
    cidr = string
    zone = string
  }))
}

variable "private-subnets" {
  type = list(object({
    name = string
    cidr = string
    zone = string
  }))
}

variable "bastion-server-subnet-name" {
  type = string
}

variable "frontend-lb-subnets-names" {
  type = list(string)
}

variable "nat-gw-subnet-name" {
  type = string
}

variable "frontend-instances-subnets-names" {
  type = list(string)
}

variable "backend-lb-subnets-names" {
  type = list(string)
}

variable "backend-instances-subnets-names" {
  type = list(string)
}

variable "database-subnets-names" {
  type = list(string)
}

variable "backend-port" {
  type = number
}

variable "database-username" {
  type      = string
  sensitive = true
}

variable "database-password" {
  type      = string
  sensitive = true
}

variable "database-name" {
  type = string
}

variable "database-port" {
  type = number
}

variable "cloudwatch-alarm-email" {
  type = string
}
