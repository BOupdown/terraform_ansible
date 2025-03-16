# Déploiement de l'application
module "app" {
    source    = "./app"
    ipaddress = "192.168.100.120"
    name      = "cytech-1-app"
    memory    = 1024
    cpu_cores = 1
    sizeDisk  = 20
    os        = "isos:iso/jammy-server-cloudimg-amd64.img"
}

# Déploiement de la base de données
module "bdd" {
    source    = "./bdd"
    ipaddress = "192.168.100.121"
    name      = "cytech-1-bdd"
    memory    = 2048
    cpu_cores = 1
    sizeDisk  = 20
    os        = "isos:iso/jammy-server-cloudimg-amd64.img"
}

# Génération de l'inventaire Ansible dynamiquement avec les IPs des outputs
resource "local_file" "ansible_inventory" {
    content = <<-EOT
    [app]
    ${module.app.resource_app.ipv4_addresses[1][0]} ansible_user=ubuntu ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

    [bdd]
    ${module.bdd.resource_bdd.ipv4_addresses[1][0]} ansible_user=ubuntu ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
    EOT
    filename = "${path.module}/inventory.yml"
}

# Exécution automatique du playbook Ansible
resource "null_resource" "ansible_playbook" {
    depends_on = [
        module.app,
        module.bdd,
        local_file.ansible_inventory
    ]

    provisioner "local-exec" {
        command = "ansible-playbook -i ${path.module}/../inventory.ini ${path.module}/../ansible/roles/main.yml"
    }

    triggers = {
        inventory_content = local_file.ansible_inventory.content
    }
}

