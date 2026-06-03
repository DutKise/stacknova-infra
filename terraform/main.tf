resource "docker_image" "nginx" {
  name         = "nginx:1.27.4"
  keep_locally = false
}

resource "docker_container" "stacknova_recette" {
  image = docker_image.nginx.image_id
  name  = "stacknova-recette"

  ports {
    internal = 80
    external = 8080
  }

  labels {
    label = "env"
    value = "recette"
  }

  labels {
    label = "project"
    value = "stacknova"
  }
}
