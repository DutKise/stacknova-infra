output "nom_conteneur" {
  description = "Nom du conteneur créé par Terraform"
  value       = docker_container.serveur_web.name
}

output "port_expose" {
  description = "Port exposé sur la machine hôte"
  value       = 8080
}
