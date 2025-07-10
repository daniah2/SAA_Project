variable "vpc-id" {
  type = string
}

variable "compute-workloads" {
  type = object({
    frontend-lb = object({
      subnets-ids = list(string)
      sg-id       = string
    })

    frontend-instances = object({
      subnets-ids = list(string)
      sg-id       = string
    })

    backend-lb = object({
      subnets-ids = list(string)
      sg-id       = string
    })

    backend-instances = object({
      subnets-ids = list(string)
      sg-id       = string
    })

    bastion-server = object({
      subnet-id = string
      sg-id     = string
    })
  })
}

variable "secrets-ssm-read-only-role-name" {
  type = string
}

variable "backend-port" {
  type = number
}

variable "database-hostname" {
  type = string
}
