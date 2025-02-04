output "all_vms" {
  value = concat(
    [for vm in yandex_compute_instance.web : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }],
    [for vm in yandex_compute_instance.databases : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }]
  )
}

output "instance_created" {
    value = try(
    { 
      for idx, instance in yandex_compute_instance.storage : 
      instance.name => {
        counter = idx
      }
    },
    "no index!"   
  )
}