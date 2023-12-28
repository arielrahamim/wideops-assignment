data "google_compute_zones" "available" {
  project = var.project
}

module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version      = "8.0.0"
  project_id   = var.project
  routing_mode = "REGIONAL"
  network_name = "${var.project}-network"

  egress_rules  = var.egress_rules
  ingress_rules = var.ingress_rules

  subnets = [
    {
      subnet_name           = "${var.project}-private-subnet"
      subnet_ip             = "10.0.0.0/16"
      subnet_private_access = "true"
      subnet_region         = var.region
    },
  ]
  secondary_ranges = {
    "${var.project}-private-subnet" = [
      {
        range_name    = "${var.project}-subnet-gke-pods"
        ip_cidr_range = "10.48.0.0/16"
      },
      {
        range_name    = "${var.project}-subnet-gke-services"
        ip_cidr_range = "10.52.0.0/16"
      },
    ]
  }
}