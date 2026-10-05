variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_name" {
  description = "Project name used as a prefix for resource names"
  type        = string
}

variable "blue_weight" {
  description = "Traffic weight for the Blue environment"
  type        = number
}

variable "green_weight" {
  description = "Traffic weight for the Green environment"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type used by Blue and Green environments"
  type        = string
}
