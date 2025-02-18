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

output "minecraft_vm_public_ip2" {
  value = google_compute_address.minecraft_ip-${var.team_id}.address  # Affiche l'IP publique de la VM
}
