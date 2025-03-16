resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "${var.name}"
  node_name = local.node_proxmox
  pool_id   = data.proxmox_virtual_environment_pool.cytech.id
  agent {
    enabled = true
  }
  memory {
    dedicated = "${var.memory}"
  }

  cpu {
    cores = "${var.cpu_cores}"
  }

  network_device {
    bridge = var.network_device_bridge
  }

  initialization {
    datastore_id = "raid-ssd"
    ip_config {
      ipv4 {
        address = "${var.ipaddress}/24"
        gateway = "192.168.100.1"
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id

    user_account {
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
      username = "ubuntu"
    }
  }

  disk {
    datastore_id = "raid-ssd"
    file_id      = "${var.os}"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = "${var.sizeDisk}"
  }

  stop_on_destroy = var.stop_on_destroy
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "mgmt"

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: test-ubuntu
    users:
      - default
      - name: ubuntu
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools
        - timedatectl set-timezone America/Toronto
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "use-drata-cloud-config-cytech-20.yaml"
  }
}
