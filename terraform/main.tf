provider "google" {
  project = var.project_id
  region  = "europe-west9"
}

resource "google_compute_instance" "minecraft_vm" {
  name         = "minecraft-server-${var.team_id}"  # Nom dynamique basé sur team_id
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/bionic-union-451212-m1/global/images/image-srv-min"  # Image de l'instance
    }
  }

  network_interface {
    network = "default"  # Réseau par défaut
    access_config {}     # Configuration de l'IP publique
  }

  tags = ["minecraft"]  # Tags pour l'instance
}

resource "google_compute_address" "minecraft_ip" {
  name = "minecraft-ip-${var.team_id}"  # Nom dynamique pour l'adresse IP
}

resource "null_resource" "add_ip_to_firestore" {
  provisioner "local-exec" {
    command = <<EOT
      curl -X POST https://REGION-PROJECT_ID.cloudfunctions.net/addIpToFirestore \
      -H "Content-Type: application/json" \
      -d '{"ip_address": "${google_compute_address.minecraft_ip.address}", "team_id": "${var.team_id}"}'
    EOT
  }

  depends_on = [
    google_compute_instance.minecraft_vm  # Dépendance à l'instance Minecraft
  ]
}

output "minecraft_vm_public_ip" {
  value = google_compute_address.minecraft_ip.address  # Affiche l'IP publique de la VM
}
