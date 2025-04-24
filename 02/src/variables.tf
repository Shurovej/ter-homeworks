### Yandex Cloud Provider Variables
variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default zone for resources"
}

### Network Variables
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "Name of the VPC network"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "Default CIDR block for the subnet"
}

### VM Naming Variables
variable "vm_web_name" {
  type        = string
  default     = "platform-web"
  description = "Name prefix for web VM"
}

variable "vm_db_name" {
  type        = string
  default     = "platform-db"
  description = "Name prefix for db VM"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone for DB VM"
}

### VM Resources Configuration (новая map-переменная)
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
    preemptible   = bool
    nat           = bool
  }))
  description = "Resources configuration for VMs"
}

### Common Metadata (новая переменная)
variable "metadata" {
  type = object({
    serial-port-enable = number
    ssh-keys           = string
  })
  description = "Common metadata for all VMs"
}

### Закомментированные старые переменные (которые заменены vms_resources)
/*
variable "vm_web_cores" {
  type        = number
  description = "Number of CPU cores for web VM"
}

variable "vm_web_memory" {
  type        = number
  description = "Memory size for web VM"
}

variable "vm_web_core_fraction" {
  type        = number
  description = "Core fraction for web VM"
}

variable "vm_db_cores" {
  type        = number
  description = "Number of CPU cores for db VM"
}

variable "vm_db_memory" {
  type        = number
  description = "Memory size for db VM"
}

variable "vm_db_core_fraction" {
  type        = number
  description = "Core fraction for db VM"
}
*/