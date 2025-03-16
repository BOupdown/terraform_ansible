output "nom_app" {
  description = "Nom de l'app"
  value       = module.app.resource_app.name
}

output "nom_bdd" {
  description = "Nom de la BDD"
  value       = module.bdd.resource_bdd.name
}

output "nombre_de_coeurs_de_app" {
  description = "Nombre de cœurs de l'app"
  value       = module.app.resource_app.cpu[0].cores
}

output "nombre_de_coeurs_de_bdd" {
  description = "Nombre de cœurs de la BDD"
  value       = module.bdd.resource_bdd.cpu[0].cores
}

output "taille_disk_de_app" {
  description = "Taille du disque de l'app"
  value       = module.app.resource_app.disk[0].size
}

output "taille_disk_de_bdd" {
  description = "Taille du disque de la BDD"
  value       = module.bdd.resource_bdd.disk[0].size
}

output "ram_de_app" {
  description = "RAM de l'app"
  value       = module.app.resource_app.memory[0].dedicated
}

output "ram_de_bdd" {
  description = "RAM de la BDD"
  value       = module.bdd.resource_bdd.memory[0].dedicated
}

output "adresse_ip_de_app" {
  description = "Adresse IP de l'app"
  value       = module.app.resource_app.ipv4_addresses[1]
}

output "adresse_ip_de_bdd" {
  description = "Adresse IP de la BDD"
  value       = module.bdd.resource_bdd.ipv4_addresses[1]
}

output "os_de_app" {
  value       = module.app.resource_app.disk[0].file_id
}

output "os_de_bdd" {
  value       = module.bdd.resource_bdd.disk[0].file_id
}

output "app_url" {
    value = "http://${module.app.resource_app.ipv4_addresses[1][0]}:8080"
}