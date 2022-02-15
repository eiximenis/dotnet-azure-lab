resource "random_id" "server" {
  keepers = {
    ami_id = "${var.resource_group}"
  }
  byte_length = 8
}


locals {
    storage_name = "img${random_id.server.hex}"
}