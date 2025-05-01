resource "yandex_compute_disk" "storage_disks" {
  count = var.storage_settings.disks_count
  
  name = "${var.storage_settings.name}-disk-${count.index + 1}"
  type = var.storage_settings.disk_type
  zone = var.default_zone
  size = var.storage_settings.disk_size_gb
}

resource "yandex_compute_instance" "storage" {
  name = var.storage_settings.name

  resources {
    cores  = var.storage_settings.vm_resources.cores
    memory = var.storage_settings.vm_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = var.network_settings.enable_nat
  }

  metadata = {
    ssh-keys = "${var.vm_metadata.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks[*].id
    content {
      disk_id = secondary_disk.value
    }
  }
}