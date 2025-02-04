resource "local_file" "ansible_inventory" {
  filename = "./inventory"
  content  = templatefile("./inventory.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
}