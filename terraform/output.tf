output "minecraft_vm_public_ip" {
  value = google_compute_address.minecraft_ip.address
}
