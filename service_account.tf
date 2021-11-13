resource "kubernetes_service_account" "sb_admin" {
  metadata {
    name      = "sb-admin"
    namespace = "default"
  }
}

resource "kubernetes_cluster_role_binding" "sb_admin" {
  metadata {
    name = "sb-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "sb-admin"
    namespace = "default"
  }
}

data "kubernetes_secret" "sb_admin_service_account" {
  metadata {
    name      = kubernetes_service_account.sb_admin.default_secret_name
    namespace = "default"
  }
}
