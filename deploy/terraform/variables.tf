variable "gen_storage" {
  type        = bool
  default     = false
  description = "Create storage for images"
}

variable "pgsql_password" {
  type        = string
  description = "PostgreSQL password"
}