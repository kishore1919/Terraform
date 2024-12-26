locals {
  count = var.vpc_count
  vpc_name = [for i in range(local.count) : "${var.vpc_name}-${i + 1}"]
  subnet_name = [for i in range(local.count) : "${var.subnet_name}-${i + 1}"]
  cidr = [for i in range(local.count) : "10.255.${14 + i * 10}.0/24"]
  vm_private_ip = [for i in range(local.count) : "10.255.${14 + i * 10}.100"]
  vm_private_ip1 = [for i in range(local.count) : "10.255.${14 + i * 10}.253"]
}

module "vpc" {
  count        = local.count
  source       = "./vpc"
  vpc_name     = local.vpc_name[count.index]
  subnet_name  = local.subnet_name[count.index]
  ip_cidr_range = local.cidr[count.index]
  region       = var.region
}

# module "vm" {
#   vm_count =  var.vpc_count
#   count = var.vpc_count
#   source      = "./vm"
#   private_ip  = local.vm_private_ip[count.index]
#   private_ip_1 = local.vm_private_ip1[count.index]
# }

