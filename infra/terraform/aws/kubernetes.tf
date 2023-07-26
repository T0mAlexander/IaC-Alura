resource "kubernetes_deployment" "django-app" {
  metadata {
    name = "django-app"
    labels = {
      name = "django"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        name = "django"
      }
    }

    template {
      metadata {
        labels = {
          name = "django"
        }
      }

      spec {
        container {
          image = "681862423314.dkr.ecr.sa-east-1.amazonaws.com/prod:v1"
          name  = "django"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/clientes/"
              port = 8000
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
  metadata {
    name = "load-balancer-django-app"
  }
  spec {
    selector = {
      name = "django"
    }
    port {
      port        = 8080
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}

data "kubernetes_service" "nome-dns" {
  metadata {
    name = "load-balancer-django-app"
  }
}

output "url" {
  value = data.kubernetes_service.nome-dns.status
}