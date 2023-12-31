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

  node_pools_oauth_scopes = var.node_pools_oauth_scopes

  depends_on = [
    module.gcp-network
  ]
}

