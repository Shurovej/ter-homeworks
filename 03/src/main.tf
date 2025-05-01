resource "yandex_vpc_network" "develop" {
  name = var.network_settings.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.network_settings.subnet_name
  zone           = var.network_settings.zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.network_settings.cidr_blocks
}