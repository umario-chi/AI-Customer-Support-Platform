resource "kubernetes_stateful_set" "qdrant" {
  metadata {
    name      = "qdrant"
    namespace = kubernetes_namespace.app.metadata[0].name

    labels = {
      app = "qdrant"
    }
  }

  spec {
    service_name = "qdrant"
    replicas     = 1

    selector {
      match_labels = {
        app = "qdrant"
      }
    }

    template {
      metadata {
        labels = {
          app = "qdrant"
        }
      }

      spec {
        container {
          name  = "qdrant"
          image = "qdrant/qdrant:v1.12.5"

          port {
            name           = "http"
            container_port = 6333
          }

          port {
            name           = "grpc"
            container_port = 6334
          }

          volume_mount {
            name       = "qdrant-storage"
            mount_path = "/qdrant/storage"
          }

          resources {
            requests = {
              cpu    = "250m"
              memory = "512Mi"
            }
            limits = {
              cpu    = "1"
              memory = "1Gi"
            }
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = 6333
            }
            initial_delay_seconds = 15
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/readyz"
              port = 6333
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "qdrant-storage"
      }

      spec {
        access_modes       = ["ReadWriteOnce"]
        storage_class_name = kubernetes_storage_class.gp3.metadata[0].name

        resources {
          requests = {
            storage = var.qdrant_storage_size
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "qdrant" {
  metadata {
    name      = "qdrant"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    selector = {
      app = "qdrant"
    }

    port {
      name        = "http"
      port        = 6333
      target_port = 6333
    }

    port {
      name        = "grpc"
      port        = 6334
      target_port = 6334
    }

    type = "ClusterIP"
  }
}
