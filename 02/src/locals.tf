locals {
  # Сохраняем старые имена, которые уже используются в инфраструктуре
  vm_web_name = "develop-netology-develop-platform-web"
  vm_db_name  = "develop-netology-develop-platform-db-ru-central1-b"
  
  common_vm_settings = {
    platform_id   = "standard-v3"
    image_family  = "ubuntu-2004-lts"
  }
}