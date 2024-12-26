variable "vpc_name" {
  description = "Name of The VPC being created"
  type        = string
  default = "cisco-sec-con-vpc-1"
}

variable "region" {
  description = "Name of The VPC being created"
  type        = string
}
variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}
variable "mtu" {
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  type        = number
  default = 1460
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = false
}

variable "subnet_name" {
  type = string
  description = "Name of The Subnet being created"
}
variable "ip_cidr_range" {
  type = string
  description = "List of The range of internal addresses that are owned by this subnetwork."
}