# azure region
variable "location" {
  type = string
  description = "Azure region where resources will be created"
  default = "north europe"
}