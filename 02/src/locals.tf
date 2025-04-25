locals {
  # Правильная интерполяция с сохранением текущего формата имен
  vm_web_name = "${var.vpc_name}-${var.vm_web_name}"
  vm_db_name  = "${var.vpc_name}-${var.vm_db_name}-${var.vm_db_zone}"
  
  common_vm_settings = {
    platform_id   = "standard-v3"
    image_family  = "ubuntu-2004-lts"
  }
}