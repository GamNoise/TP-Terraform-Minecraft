packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = ">= 0.0.1"
    }
  }
}

source "googlecompute" "default" {
  project_id      = "bionic-union-451212-m1"
  source_image    = "vm-template"
  machine_type    = "e2-medium"
  zone            = "europe-west1-b"
  image_name      = "image-vm-template"
  image_family    = "vm-template-images"
  image_description = "Image Packer de vm-template"
  ssh_username    = "ubuntu"  # Remplace par le nom d'utilisateur approprié
}

build {
  sources = ["source.googlecompute.default"]
}