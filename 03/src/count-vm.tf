resource "yandex_compute_instance" "web" {
  count = var.web_vms_settings.count
  name  = "${var.web_vms_settings.name_prefix}-${count.index + 1}"

  resources {
    cores  = var.web_vms_settings.resources.cores
    memory = var.web_vms_settings.resources.memory
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
}