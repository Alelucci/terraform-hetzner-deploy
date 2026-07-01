output "server_ip" {
  value = hcloud_server.web1.ipv4_address
}

output "server_id" {
  value = hcloud_server.web1.id
}
