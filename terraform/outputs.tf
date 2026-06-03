output "nom_conteneur" {
  description = "Nom du conteneur créé par Terraform"
  value       = docker_container.stacknova_recette.name
}

output "port_expose" {
  description = "Port exposé sur la machine hôte"
  value       = 8080
}
