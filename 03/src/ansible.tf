resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tftpl", {
    web_vms    = [for vm in yandex_compute_instance.web : {
      name              = vm.name
      network_interface = vm.network_interface
    }],
    db_vms     = [for _, vm in yandex_compute_instance.db : {
      name              = vm.name
      network_interface = vm.network_interface
    }],
    storage_vms = [{
      name              = yandex_compute_instance.storage.name
      network_interface = yandex_compute_instance.storage.network_interface
    }],
    ssh_user   = var.vm_metadata.ssh_user,
    ssh_key    = var.ssh_public_key_path,
    inventory_filename = var.inventory_filename
  })
  filename = var.inventory_filename
}