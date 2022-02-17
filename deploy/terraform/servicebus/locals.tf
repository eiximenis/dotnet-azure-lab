resource "random_id" "server" {
  keepers = {
    ami_id = "${var.resource_group}"
  }
  byte_length = 8
}

locals {
    namespace = "beers${random_id.server.hex}"
}

