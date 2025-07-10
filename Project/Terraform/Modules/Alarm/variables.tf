variable "alarm-email" {
  description = "Email address for SNS notifications"
  type        = string
}

variable "cpu-utilization-threshold" {
  description = "CPU utilization percentage to trigger alarm"
  type        = number
  default     = 80
}

variable "asg-names" {
  description = "List of Auto Scaling Group names to monitor"
  type        = map(string)
}
