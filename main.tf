terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

data "hcloud_ssh_key" "default" {
  name = var.sshkey_name
}

resource "hcloud_network" "network1" {
  name     = var.net_name
  ip_range = "10.0.1.0/24"
}

resource "hcloud_network_subnet" "subnet1" {
  type         = "cloud"
  network_id   = hcloud_network.network1.id
  network_zone = var.subnet_zone
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_firewall" "firewall1" {
  name = var.fw_name
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  dynamic "rule" {
    for_each = var.fw_allowed_in_tcp_ports
    content {
      direction  = "in"
      protocol   = "tcp"
      port       = rule.value
      source_ips = ["0.0.0.0/0", "::/0"]
    }
  }

}

resource "hcloud_server" "web1" {
  name         = var.server_name
  server_type  = var.server_type
  image        = var.image
  location     = var.location
  ssh_keys     = [data.hcloud_ssh_key.default.id]
  firewall_ids = [hcloud_firewall.firewall1.id]

  network {
    subnet_id = hcloud_network_subnet.subnet1.id
    ip        = "10.0.1.5"
    alias_ips = [
      "10.0.1.6",
      "10.0.1.7"
    ]
  }
}
