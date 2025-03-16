terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  insecure = var.proxmox_insecure
  username = var.proxmox_username
  password = var.proxmox_password
  ssh {
    username = var.ssh_username
    agent    = var.ssh_agent
  }
}