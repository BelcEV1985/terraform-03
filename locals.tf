locals {
  ssh_key = file("~/.ssh/d.pub")
}

locals {
  webservers = {
    for idx, instance in yandex_compute_instance.web : 
    instance.name => {
      ip   = instance.network_interface[0].ip_address
      fqdn = instance.fqdn
    }
  }

  databases = {
    for idx, instance in yandex_compute_instance.databases : 
    instance.name => {
      ip   = instance.network_interface[0].ip_address
      fqdn = instance.fqdn
    }
  }

  storage = try(
    
    { 
      for idx, instance in yandex_compute_instance.storage : 
      instance.name => {
        ip   = instance.network_interface[0].ip_address
        fqdn = instance.fqdn
        error_marker = "have index"
      }
    },
    {
      "${yandex_compute_instance.storage.name}" = {
        ip   = yandex_compute_instance.storage.network_interface[0].ip_address
        fqdn = yandex_compute_instance.storage.fqdn
        error_marker = "no index!"
      }
    }
  )
}