###################
##### GLOBAL ######
###################

project = "wideops-assignment"
region  = "me-west1"


###################
#### NETWORKING ###
###################

egress_rules = [{
  name               = "all-traffic-outside"
  destination_ranges = ["0.0.0.0/0"]
  allow = [{
    protocol = "all"
    ports    = []
  }]
  }
]


ingress_rules = [
  {
    name          = "all-ssh-access"
    source_ranges = ["0.0.0.0/0"]
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
  },
  {
    name          = "all-inside-traffic"
    source_ranges = ["10.0.0.0/16", "10.48.0.0/16", "10.52.0.0/16"]
    allow = [{
      protocol = "all"
      ports    = []
    }]
  }
]


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


#################
###### GKE ######
#################

zones = ["me-west1-a", "me-west1-b"]

node_pools = [
  {
    name         = "node-pool"
    machine_type = "e2-medium"
    zones        = "me-west1-a"
    min_count    = 1
    max_count    = 1
    disk_size_gb = 20
    spot         = true
    auto_upgrade = true
    auto_repair  = true
    autoscaling  = true
  },
]


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

#################
#### COMPUTE ####
#################

machine_type    = "e2-medium"
image           = "ubuntu-2204-jammy-v20231213a"
mongo_instances = ["mongo-primary", "mongo-replica", "mongo-arbiter"]