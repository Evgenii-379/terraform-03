resource "yandex_compute_instance" "web" {
  count        = 2
  name         = "web-${count.index + 1}"                             # Создание 2-х VM web-1 и web-2
  zone         = var.default_zone
  platform_id  = var.platform_id

  
  resources {
    cores          = var.cores
    memory         = var.memory
    core_fraction  = var.core_fraction
  }




  boot_disk {
    initialize_params {
      image_id = var.image_id                                          # Используем переменную для ID образа
    }
 }


network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]            # Привязываем к группе безопасности
 }

metadata = {
    ssh-keys = file("~/.ssh/id_rsa.pub")

 }

}
