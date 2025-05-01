variable "token" {
  type        = string
  description = "OAuth-token for Yandex Cloud authorization"
}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Folder ID in Yandex Cloud"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default availability zone"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "Default CIDR block for subnet"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network name"
}

variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image family"
}

variable "vm_resources" {
  type = object({
    cores  = number
    memory = number
  })
  default = {
    cores  = 2
    memory = 2
  }
}

variable "vm_metadata" {
  type = object({
    ssh_user = string
  })
  default = {
    ssh_user = "ubuntu"
  }
}

variable "db_vms_settings" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
    disk_type   = string
  }))
  default = [
    {
      vm_name     = "main",
      cpu         = 4,
      ram         = 8,
      disk_volume = 20,
      disk_type   = "network-hdd"
    },
    {
      vm_name     = "replica",
      cpu         = 2,
      ram         = 4,
      disk_volume = 10,
      disk_type   = "network-hdd"
    }
  ]
}

variable "ssh_public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to SSH public key"
}

variable "storage_settings" {
  type = object({
    name         = string
    disks_count  = number
    disk_size_gb = number
    disk_type    = string
    vm_resources = object({
      cores  = number
      memory = number
    })
  })
  default = {
    name         = "storage",
    disks_count  = 3,
    disk_size_gb = 1,
    disk_type    = "network-hdd",
    vm_resources = {
      cores  = 2,
      memory = 2
    }
  }
}

variable "web_vms_settings" {
  type = object({
    count       = number
    name_prefix = string
    resources   = object({
      cores  = number
      memory = number
    })
  })
  default = {
    count       = 2,
    name_prefix = "web",
    resources   = {
      cores  = 2,
      memory = 2
    }
  }
}

variable "network_settings" {
  type = object({
    vpc_name    = string
    subnet_name = string
    zone        = string
    cidr_blocks = list(string)
    enable_nat  = bool
  })
  default = {
    vpc_name    = "develop",
    subnet_name = "develop",
    zone        = "ru-central1-a",
    cidr_blocks = ["10.0.1.0/24"],
    enable_nat  = true
  }
}
variable "inventory_filename" {
  type        = string
  default     = "inventory.ini"
  description = "Name for generated Ansible inventory file"
}