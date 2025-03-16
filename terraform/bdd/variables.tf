variable "name" {
  type    = string
}

variable "pool_id" {
  type    = string
  default = "cytech"
}

variable "sizeDisk" {
  type = number
}

variable "cpu_cores" {
  type    = number
}

variable "os" {
  type = string
}

variable "ipaddress" {
  type = string
}

variable "memory" {
  type    = number
}

variable "network_device_bridge" {
  type    = string
  default = "vmbr0"
}

variable "stop_on_destroy" {
  type    = bool
  default = true
}

variable "proxmox_endpoint" {
  type    = string
  default = "https://192.168.100.12:8006/"
}

variable "proxmox_insecure" {
  type    = bool
  default = true
}

variable "proxmox_username" {
  type    = string
  default = "cytech-1@pam"
}

variable "proxmox_password" {
  type    = string
  default = "cytech"
}

variable "ssh_username" {
  type    = string
  default = "cytech"
}

variable "ssh_agent" {
  type    = bool
  default = true
}