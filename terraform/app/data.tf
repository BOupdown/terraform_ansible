data "proxmox_virtual_environment_pool" "cytech" {
  pool_id = "cytech"
}

data "local_file" "ssh_public_key" {
  filename = "/home/cytech/.ssh/id.pub"
}

