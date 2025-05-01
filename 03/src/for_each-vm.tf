resource "yandex_compute_instance" "db" {  
  for_each = { for vm in var.db_vms_settings : vm.vm_name => vm }  

  name = each.key  

  resources {  
    cores  = each.value.cpu  
    memory = each.value.ram  
  }  

  boot_disk {  
    initialize_params {  
      image_id = data.yandex_compute_image.ubuntu.image_id  
      size     = each.value.disk_volume  
      type     = each.value.disk_type  
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