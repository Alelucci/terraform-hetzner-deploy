variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "server_name" {
  description = "Name of the VM"
  type        = string
  default     = "hetzner-server"
}

variable "server_type" {
  description = "Machine type"
  type        = string
  default     = "cx23"
}

variable "location" {
  description = "Datacenter location"
  type        = string
  default     = "nbg1"
}

variable "image" {
  description = "Operating system image"
  type        = string
  default     = "ubuntu-24.04"
}

variable "net_name" {
  description = "Network's name"
  type        = string
  default     = "my_network"
}

variable "subnet_zone" {
  description = "Subnet's location"
  type        = string
  default     = "eu-central"
}

variable "fw_name" {
  description = "Firewall's name"
  type        = string
  default     = "my_firewall"
}

variable "fw_allowed_in_tcp_ports" {
  type        = list(string)
  description = "List of allowed inbound TCP ports"
  default     = ["22", "80"]
}

variable "sshkey_name" {
  type        = string
  description = "Name of the ssh key used in the hetzner project"
  sensitive   = true
}
