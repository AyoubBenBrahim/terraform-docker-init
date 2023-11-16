
# Set the required provider and versions
terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
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

# locals {
#   login_name = var.LOGNAME != "" ? var.LOGNAME : ""
# }

# Configure the docker provider
provider "docker" {
  host = "unix:///Users/${var.login}/.docker/run/docker.sock"
}


# Create a docker image resource
# -> docker pull nginx:latest
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true // docker image will be deleted after the container is created false
}

# Create a docker container resource
# -> same as 'docker run --name nginx -p8080:80 -d nginx:latest'
resource "docker_container" "nginx" {
  name  = "nginx_container"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
  }
}
