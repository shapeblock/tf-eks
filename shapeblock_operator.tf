data "kubectl_path_documents" "shapeblock_crds" {
  pattern = "./shapeblock/*.yaml"
}

resource "kubectl_manifest" "shapeblock_crds" {
  count      = length(data.kubectl_path_documents.shapeblock_crds.documents)
  yaml_body  = element(data.kubectl_path_documents.shapeblock_crds.documents, count.index)
  depends_on = [kubernetes_service_account.sb_admin]
}

resource "kubernetes_deployment" "shapeblock_operator" {
  metadata {
    name = "sb-operator"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        application = "sb-operator"
      }
    }

    template {
      metadata {
        labels = {
          application = "sb-operator"
        }
      }

      spec {
        container {
          name  = "sb-operator"
          image = "shapeblock/sb-operator:0.0.9"

          env {
            name  = "SB_URL"
            value = var.sb_url
          }

          env {
            name = "CLUSTER_ID"
            value = var.cluster_uuid
          }

          image_pull_policy = "Always"
        }

        service_account_name = "sb-admin"
      }
    }

    strategy {
      type = "Recreate"
    }
  }
  depends_on = [kubernetes_service_account.sb_admin]
}

