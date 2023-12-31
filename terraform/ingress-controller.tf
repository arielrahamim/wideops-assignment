locals {
  ingress_ValuesOverride = <<EOT
controller:
  extraArgs:
    enable-ssl-passthrough: ""
  EOT
}

resource "helm_release" "nginx_ingress_controller" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  values     = [local.ingress_ValuesOverride]
  depends_on = [module.gke]
}