variable "proxmox_url" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "proxmox_password" {
  type = string
  sensitive = true
}

variable "proxmox_username" {
  type = string
  default = "packer@pam"
}

variable "ssh_username" {
  type = string
  default = "ubuntu"
}

variable "ssh_private_key" {
  type = string
  sensitive = true
}

source "proxmox-clone" "ubuntu" {
  proxmox_url = "${var.proxmox_url}"
  username = "${var.proxmox_username}"
  password = "${var.proxmox_password}"
  node = "${var.proxmox_node}"
  clone_vm = "ubuntu-22.04-template"

  cores = 2
  ballooning_minimum = 1024
  full_clone = true
  insecure_skip_tls_verify = true
  memory = 2048
  scsi_controller = "virtio-scsi-single"
  template_description = "Prometheus and Grafana in one image"
  template_name = "monitoring-template"
  vm_id = 9002

  cloud_init = true
  cloud_init_storage_pool = "local-lvm"

  ssh_username = "${var.ssh_username}"
}

build {
  sources = ["source.proxmox-clone.ubuntu"]

    provisioner "ansible" {
      playbook_file = "../monitoring.yml"
      host_alias = "monitoring"
      use_proxy = false
      extra_arguments = [
        "--extra-vars",
        "start_services=true"
      ]
    }
}
