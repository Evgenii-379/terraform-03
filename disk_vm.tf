resource "yandex_compute_disk" "disks" {
  count = 3
  name  = "disk-${count.index + 1}"
  size  = 1                                            # Размер в GB
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  zone        = var.default_zone
  platform_id = var.platform_id

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id            = yandex_vpc_subnet.develop.id
    nat                  = true
    security_group_ids   = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = file("~/.ssh/id_rsa.pub")
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks
    content {
      disk_id     = secondary_disk.value.id
      auto_delete = true
    }
  }
}
