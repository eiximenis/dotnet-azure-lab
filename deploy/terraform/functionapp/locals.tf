resource "random_id" "server" {
  keepers = {
    ami_id = "${var.resource_group}"
  }
  byte_length = 8
}

locals {
    functionapp_name = "beersfunc${random_id.server.hex}"
    svcplan_name = "beersfuncplan${random_id.server.hex}"
    storage_name = "beersfuncsa${random_id.server.hex}"
}