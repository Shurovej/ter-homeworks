variable "security_group_name" {
  type        = string
  default     = "example_dynamic"
}

variable "security_group_ingress" {
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить входящий ssh"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий http"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий https"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    }
  ]
}

variable "security_group_egress" {
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить весь исходящий трафик"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65365
    }
  ]
}

resource "yandex_vpc_security_group" "example" {
  name       = var.security_group_name
  network_id = yandex_vpc_network.develop.id
  folder_id  = var.folder_id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      protocol       = ingress.value.protocol
      description    = ingress.value.description
      v4_cidr_blocks = ingress.value.v4_cidr_blocks
      port           = ingress.value.port
      from_port      = ingress.value.from_port
      to_port        = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      protocol       = egress.value.protocol
      description    = egress.value.description
      v4_cidr_blocks = egress.value.v4_cidr_blocks
      from_port      = egress.value.from_port
      to_port        = egress.value.to_port
    }
  }
}