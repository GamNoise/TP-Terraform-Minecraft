provider "google" {
  project = "your-project-id"
  region  = "europe-west1"
}

resource "google_compute_instance" "minecraft_vm" {
  name         = "minecraft-server"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  image        = "projects/your-project-id/global/images/minecraft-server-image"

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.minecraft_ip.address
    }
  }

  tags = ["minecraft"]
}

resource "google_compute_address" "minecraft_ip" {
  name = "minecraft-ip"
}

resource "null_resource" "add_ip_to_firestore" {
  provisioner "local-exec" {
    command = <<EOT
      curl -X POST https://REGION-PROJECT_ID.cloudfunctions.net/addIpToFirestore \
      -H "Content-Type: application/json" \
      -d '{"ip_address": "${google_compute_address.minecraft_ip.address}", "team_id": "team-id"}'
    EOT
  }

  depends_on = [
    google_compute_instance.minecraft_vm
  ]
}

output "minecraft_vm_public_ip" {
  value = google_compute_address.minecraft_ip.address
}
