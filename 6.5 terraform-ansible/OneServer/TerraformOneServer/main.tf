## Yandex.Cloud
variable "yc_token" {
  type        = string
  description = "Yandex Cloud API key"
}
variable "yc_region" {
  type        = string
  description = "Yandex Cloud Region (i.e. ru-central1-a)"
}
variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud id"
}
variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud folder id"
}

# Provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      #version = ">= 0.13"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_region
}

## network
resource "yandex_vpc_network" "internal" {
  name = "internal"
}

resource "yandex_vpc_subnet" "internal-a" {
  name           = "internal-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.internal.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

## instance
resource "yandex_compute_instance" "vm-1" {
  name        = "skillbox-6-5"
  platform_id = "standard-v3"

  resources {
    # Данный параметр позволяет уменьшить производительность CPU и сильно
    # уменьшить затраты на инфраструктуру
    core_fraction = 50
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ciuqfa001h8s9sa7i"
      type     = "network-hdd"
      size     = 15
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.internal-a.id
    nat       = true
  }

  metadata = {
    ssh-keys = "sergey:${file("~/.ssh/id_rsa.pub")}"
  }
}

# Выведем IP адресa сервера
output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
