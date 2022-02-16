variable "scenario" {
  type = number
  description = "The scenario to generate"
}

variable "pgsql_password" {
  type        = string
  description = "PostgreSQL password"
}

variable "resource_group" {
  type       = string
  description = "Resource group name"
  default = "beers"
}

variable "location"  {
  type       = string
  description = "Location for all resources"
  default = "West Europe"
}