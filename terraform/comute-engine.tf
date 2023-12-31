resource "google_compute_instance" "default" {
  for_each                  = toset(var.mongo_instances)
  name                      = each.key
  machine_type              = var.machine_type
  zone                      = var.zones[0]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.image
      labels = {
        my_label = "${each.key}"
      }
    }
  }

  network_interface {
    subnetwork = "${var.project}-private-subnet"
    network    = module.gcp-network.network_self_link
    access_config {
      // Include this section to give the VM an external IP address
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = <<EOT
  curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
  sudo apt-get update -y
  sudo apt-get install -y mongodb-org
  sudo systemctl daemon-reload
  sudo systemctl start mongod
  sudo systemctl enable mongod
  EOT
}