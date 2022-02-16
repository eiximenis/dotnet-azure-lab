variable "uai" {
    type = string
    default = null
}


variable "key_vault_url" {
    type = string
    default = null
}

variable "resource_group" {
    type = string
}

variable "db_constr" {
    type = string
    description = "Db connection string"
}

variable "url_images" {
    type = string
    description = "Base URLs for images"
}
