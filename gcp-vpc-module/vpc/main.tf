resource "google_compute_network" "this" {
  name                                      = "${var.vpc_name}"
  delete_default_routes_on_create           = var.delete_default_internet_gateway_routes
  auto_create_subnetworks                   = var.auto_create_subnetworks
  routing_mode                              = "REGIONAL"
  mtu                                       = var.mtu
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.this.name
  private_ip_google_access = true
}