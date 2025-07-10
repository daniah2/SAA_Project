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
