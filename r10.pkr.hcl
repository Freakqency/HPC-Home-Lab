variable "disk_size" {
  type    = number
  default = 10240
}

packer {
  required_plugins {
    vmware = {
      version = "~> 1"
      source  = "github.com/hashicorp/vmware"
    }
    vagrant = {
      version = "~> 1"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "vmware-iso" "r10" {
  iso_url          = "https://download.rockylinux.org/pub/rocky/10/isos/aarch64/Rocky-10.0-aarch64-minimal.iso"
  iso_checksum     = "sha256:042be2dfd33e0a8cf4262c160d793660e16c3eee46b236120e86a40e867ddc96"
  ssh_username     = "vagrant"
  ssh_password     = "vagrant"
  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"
  http_directory   = "kickstart"
  boot_wait        = "5s"
  boot_command = [
    "e<wait><down><down><wait><end><wait>",
    "  inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg ip=dhcp",
    "<wait><f10><wait>"
  ]
  headless             = true
  cpus                 = 2
  memory               = 2048
  disk_size            = var.disk_size
  version              = "21"
  disk_adapter_type    = "nvme"
  network_adapter_type = "e1000e"
  guest_os_type        = "arm-rhel10-64"
  usb                  = true
  vmx_data = {
    architecture = "arm64"
  }
}

build {
  name = "r10"
  sources = ["source.vmware-iso.r10"]
  post-processor "vagrant" {
    output = "/Users/surya/Projects/Vagrant-Boxes/r10-base.box"
  }
}

build {
  name = "r10-controller"
  sources = ["source.vmware-iso.r10"]
  variables = {
    disk_size = 15360
  }
  post-processor "vagrant" {
    output = "/Users/surya/Projects/Vagrant-Boxes/r10-controller.box"
  }
}