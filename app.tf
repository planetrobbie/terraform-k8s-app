provider "kubernetes" {}

resource "kubernetes_replication_controller" "bookshelf_rc" {
  metadata {
    name = "bookshelf"

    labels {
      app = "bookshelf_app"
    }
  }

  lifecycle {
    create_before_destroy = "true"
  }

  spec {
    replicas = 3

    selector {
      app = "bookshelf_app"
    }

    template {
      container {
        image = "gcr.io/sebbraun-yet/bookshelf:v1"
        name  = "bookshelf"

        image_pull_policy = "Always"

        port {
          container_port = 8080
        }

        env {
          name  = "PROCESSES"
          value = "bookshelf"
        }
      }
    }
  }
}

resource "kubernetes_service" "bookshelf_svc" {
  metadata {
    name = "bookshelf-frontend"
  }

  spec {
    selector {
      app = "bookshelf_app"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

output "ip_address" {
  value = "${kubernetes_service.bookshelf_svc.load_balancer_ingress.0.ip}"
}
