resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tftpl", {
    web_vms = yandex_compute_instance.web[*],
    db_vms  = values(yandex_compute_instance.db),
    storage_vm = yandex_compute_instance.storage,
    ssh_user = var.vm_metadata.ssh_user,
    ssh_key  = var.ssh_public_key_path
  })
  filename = "inventory.ini"
}