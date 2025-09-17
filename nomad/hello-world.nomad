job "helpdesk_hello" {
  datacenters = ["dc1"]
  type = "service"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  group "web" {
    count = 1

    network {
      port "nginx" {
        static = 8080
      }

      port "django_app" {
        static = 8000
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "atharhussain/helpdesk_repo:nginx"
        ports = ["nginx"]
      }

      resources {
        cpu    = 60
        memory = 30
      }

      service {
        name = "nginx-proxy"
        port = "nginx"
        tags = ["nginx"]
      }
    }

    task "django_app" {
      driver = "docker"

      config {
        image = "atharhussain/helpdesk_repo:web-v2"
        ports = ["django_app"]
      }

      resources {
        cpu    = 100
        memory = 64
      }

      service {
        name = "django-service"
        port = "django_app"
        tags = ["django"]
      }
    }
  }
}
