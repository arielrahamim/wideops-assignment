data "google_compute_zones" "available" {
  project = var.project
}

module "gcp-network" {
  source           = "terraform-google-modules/network/google"
  version          = "8.0.0"
  project_id       = var.project
  routing_mode     = "REGIONAL"
  network_name     = "${var.project}-network"
  egress_rules     = var.egress_rules
  ingress_rules    = var.ingress_rules
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}