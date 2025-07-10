module "network" {
  source             = "./Modules/Network"
  vpc-cidr           = var.vpc-cidr
  public-subnets     = var.public-subnets
  private-subnets    = var.private-subnets
  nat-gw-subnet-name = var.nat-gw-subnet-name
  backend-port       = var.backend-port
  database-port      = var.database-port
}

module "compute" {
  source                          = "./Modules/Compute"
  vpc-id                          = module.network.vpc-id
  backend-port                    = var.backend-port
  database-hostname               = module.database.database-hostname
  secrets-ssm-read-only-role-name = module.security.secrets-ssm-read-only-role-name

  compute-workloads = {
    frontend-lb = {
      subnets-ids = [for subnet-name, subnet-id in module.network.public-subnets-ids : subnet-id if contains(var.frontend-lb-subnets-names, subnet-name)]
      sg-id       = module.network.security-groups-ids["frontend-load-balancer-sg"]
    }

    frontend-instances = {
      subnets-ids = [for subnet-name, subnet-id in module.network.private-subnets-ids : subnet-id if contains(var.frontend-instances-subnets-names, subnet-name)]
      sg-id       = module.network.security-groups-ids["frontend-instances-sg"]
    }

    backend-lb = {
      subnets-ids = [for subnet-name, subnet-id in module.network.private-subnets-ids : subnet-id if contains(var.backend-lb-subnets-names, subnet-name)]
      sg-id       = module.network.security-groups-ids["backend-load-balancer-sg"]
    }

    backend-instances = {
      subnets-ids = [for subnet-name, subnet-id in module.network.private-subnets-ids : subnet-id if contains(var.backend-instances-subnets-names, subnet-name)]
      sg-id       = module.network.security-groups-ids["backend-instances-sg"]
    }

    bastion-server = {
      subnet-id = [for subnet-name, subnet-id in module.network.public-subnets-ids : subnet-id if subnet-name == var.bastion-server-subnet-name][0]
      sg-id     = module.network.security-groups-ids["bastion-server-sg"]
    }
  }
}

module "database" {
  source               = "./Modules/Storage"
  database-subnets-ids = [for subnet-name, subnet-id in module.network.private-subnets-ids : subnet-id if contains(var.database-subnets-names, subnet-name)]
  database-sg-id       = module.network.security-groups-ids["rds-instances-sg"]
  database-username    = var.database-username
  database-password    = var.database-password
  database-name        = var.database-name
}

module "security" {
  source            = "./Modules/Security"
  backend-port      = var.backend-port
  database-username = var.database-username
  database-password = var.database-password
  database-name     = var.database-name
  database-port     = var.database-port
}

module "alarm" {
  source      = "./Modules/Alarm"
  alarm-email = var.cloudwatch-alarm-email
  asg-names   = module.compute.asg-names
  depends_on = [module.compute]
}
