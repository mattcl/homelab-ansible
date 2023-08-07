packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }

    proxmox = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}
