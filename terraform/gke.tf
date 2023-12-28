module "gke" {
  source              = "terraform-google-modules/kubernetes-engine/google"
  version             = "29.0.0"
  project_id          = var.project
  name                = "${var.project}-gke-cluster"
  regional            = true
  region              = var.region
  zones               = var.zones
  network             = module.gcp-network.network_name
  subnetwork          = module.gcp-network.subnets_names[0]
  ip_range_pods       = "${var.project}-subnet-gke-pods"
  ip_range_services   = "${var.project}-subnet-gke-services"
  deletion_protection = false

  node_pools = var.node_pools

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/servicecontrol",
    ]
  }

  depends_on = [
    module.gcp-network
  ]
}

