variable "resource_group" {
    type = string
}

variable "create_uai" {
    type = bool
}

variable "db_constr" {
    type = string
    description = "Db connection string"
}