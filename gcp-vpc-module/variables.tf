variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "region" {
  description = "The Region in the project where this VPC will be created"
  type        = string
}
variable "vpc_count" {
  description = "The Region in the project where this VPC will be created"
  type        = number
}

variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
  default = "cisco-sec-con-vpc"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default = "cisco-sec-con-subnet"
}
