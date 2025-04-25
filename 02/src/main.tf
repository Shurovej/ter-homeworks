resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = "${var.vpc_name}-db"
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

data "yandex_compute_image" "ubuntu" {
  family = local.common_vm_settings.image_family
}

# Web VM
resource "yandex_compute_instance" "platform" {
  zone           = var.default_zone
  name           = local.vm_web_name
  platform_id    = local.common_vm_settings.platform_id
  
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.web.hdd_type
      size     = var.vms_resources.web.hdd_size
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources.web.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.web.nat
  }

  metadata = var.metadata

  lifecycle {
    ignore_changes = [
      network_interface[0].nat_ip_address,  # Игнорировать изменения IP-адреса
      name                                 # Опционально: если хотите сохранить текущее имя
    ]
  }
}

# DB VM
resource "yandex_compute_instance" "platform_db" {
  zone           = var.vm_db_zone
  name           = local.vm_db_name
  platform_id    = local.common_vm_settings.platform_id
  
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.db.hdd_type
      size     = var.vms_resources.db.hdd_size
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources.db.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.vms_resources.db.nat
  }

  metadata = var.metadata

        lifecycle {
    ignore_changes = [
      network_interface[0].nat_ip_address,  # Игнорировать изменения IP-адреса
      name                                 # Опционально: если хотите сохранить текущее имя
    ]
  }
}