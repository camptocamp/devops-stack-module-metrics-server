locals {
  helm_values = [{
    metrics-server = {
      args = [
        var.kubelet_insecure_tls ? "--kubelet-insecure-tls" : null,
      ]
      resources = {
        requests = { for k, v in var.resources.requests : k => v if v != null }
        limits   = { for k, v in var.resources.limits : k => v if v != null }
      }
    }
  }]
}
