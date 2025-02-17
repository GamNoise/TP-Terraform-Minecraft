# Configuration du fournisseur Google Cloud
provider "google" {
  project = "bionic-union-451212-m1"  # ID du projet Google Cloud
  region  = "europe-west9"            # Région Google Cloud
}

# Ressource pour créer une instance de machine virtuelle Google Compute Engine
resource "google_compute_instance" "minecraft_vm" {
  name         = "minecraft-server"   # Nom de l'instance
  machine_type = "e2-medium"          # Type de machine
  zone         = "europe-west1-b"     # Zone de l'instance
  image        = "projects/your-project-id/global/images/minecraft-server-image"  # Image de l'instance

  # Configuration de l'interface réseau
  network_interface {
    network = "default"  # Réseau par défaut
    access_config {
      nat_ip = google_compute_address.minecraft_ip.address  # Adresse IP NAT
    }
  }

  tags = ["minecraft"]  # Tags pour l'instance
}

# Ressource pour créer une adresse IP statique
resource "google_compute_address" "minecraft_ip" {
  name = "minecraft-ip"  # Nom de l'adresse IP
}

# Ressource pour ajouter l'adresse IP à Firestore via une fonction Cloud
resource "null_resource" "add_ip_to_firestore" {
  provisioner "local-exec" {
    command = <<EOT
      curl -X POST https://REGION-PROJECT_ID.cloudfunctions.net/addIpToFirestore \
      -H "Content-Type: application/json" \
      -d '{"ip_address": "${google_compute_address.minecraft_ip.address}", "team_id": "team-id"}'
    EOT
  }

  depends_on = [
    google_compute_instance.minecraft_vm  # Dépendance à l'instance Minecraft
  ]
}

# Sortie de l'adresse IP publique de l'instance Minecraft
output "minecraft_vm_public_ip" {
  value = google_compute_address.minecraft_ip.address  # Valeur de l'adresse IP
}
