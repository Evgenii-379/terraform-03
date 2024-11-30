variable "each_vm" {
  type = list(object({
    vm_name       = string,
    cpu           = number,
    ram           = number,
    disk_volume   = number,
    core_fraction = number
  }))
  
  default = [
    {
      vm_name       = "main",
      cpu           = 4,
      ram           = 8,
      disk_volume   = 10,
      core_fraction = 5
    },
    {
      vm_name       = "replica",
      cpu           = 2,
      ram           = 4,
      disk_volume   = 20,
      core_fraction =5
    }
  ]
}

resource "yandex_compute_instance" "db" {
  for_each     = { for vm in var.each_vm : vm.vm_name => vm }
  
  name         = each.key
  zone         = var.default_zone
  platform_id  = var.platform_id                                          

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.core_fraction 
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id                                      
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
}

metadata = {
    ssh-keys = file("~/.ssh/id_rsa.pub")
 } 

}

