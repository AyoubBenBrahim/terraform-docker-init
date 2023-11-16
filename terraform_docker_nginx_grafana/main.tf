# Set the required provider and versions
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

# Set the variables
variable "login" {
  description = "User login name"
  default     = ""
}

# Configure the docker provider
provider "docker" {
  host = "unix:///Users/${var.login}/.docker/run/docker.sock"
}

# Create a docker image resource
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

# Create a docker container resource for Grafana
resource "docker_container" "grafana" {
  name  = "grafana_container"
  image = "grafana/grafana:latest"

  ports {
    internal = 3000
    external = 8081
  }
}

# Create a docker container resource for Nginx
resource "docker_container" "nginx" {
  name  = "nginx_container"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
  }

  provisioner "local-exec" {
    command = "docker cp ${path.module}/default.conf ${docker_container.nginx.name}:/etc/nginx/conf.d/default.conf"
  }
}