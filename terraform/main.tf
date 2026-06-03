resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "serveur_web" {
  image = docker_image.nginx.image_id
  name  = "serveur-web-terraform"

  ports {
    internal = 80
    external = 8080
  }

  labels {
    label = "gere_par"
    value = "terraform"
  }
}
