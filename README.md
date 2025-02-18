# TP-Terraform-Minecraft 🎮

## Description 📝

Ce projet vise à automatiser la création et la configuration d'un serveur Minecraft sur Google Cloud Platform (GCP) à l'aide de Terraform et Ansible. Chaque équipe dispose d'une instance de serveur Minecraft isolée, déployée dynamiquement lors de l'inscription.

## Table des Matières 📌

- [Prérequis](#prerequis)
- [Installation et Configuration](#installation-et-configuration)
- [Déploiement avec Terraform](#deploiement-avec-terraform)
- [Configuration avec Ansible](#configuration-avec-ansible)
- [Création d'une Image de l'Instance](#creation-dune-image-de-linstance)
- [Surveillance et Sauvegarde](#surveillance-et-sauvegarde)
- [Gestion de Projet et Versionning](#gestion-de-projet-et-versionning)
- [Améliorations Futures](#ameliorations-futures)
- [Mentions](#mentionss)

---

## Prérequis ✅

Avant de commencer, assurez-vous d'avoir :

- Un compte Google Cloud avec les API requises activées ☁️
- Terraform installé sur votre machine locale 🏗️
- Ansible installé sur votre machine locale ou sur la VM GCP 🤖
- Accès SSH à votre VM sur GCP 🔑
- Une paire de clés SSH générée pour l'authentification 🔐

## Installation et Configuration ⚙️

### 1. Configuration SSH sur la VM 🔑

Générez une paire de clés SSH et ajoutez-la à votre instance GCP :

```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa_gcp
gcloud compute instances add-metadata NOM_DE_LINSTANCE --metadata "ssh-keys=ubuntu:$(cat ~/.ssh/id_rsa_gcp.pub)"
```

Remplacez `NOM_DE_LINSTANCE` par le nom réel de votre instance.

### 2. Récupération des fichiers Ansible sur la VM 📂

Sur votre VM, exécutez les commandes suivantes pour télécharger les fichiers Ansible :

```sh
wget -O playbook-ansible.yml "https://raw.githubusercontent.com/GamNoise/TP-Terraform-Minecraft/main/ansible/playbook-ansible.yml"
wget -O inventory.ini "https://raw.githubusercontent.com/GamNoise/TP-Terraform-Minecraft/main/ansible/inventory.ini"
wget -O ansible.cfg "https://raw.githubusercontent.com/GamNoise/TP-Terraform-Minecraft/main/ansible/ansible.cfg"
```

Puis installez Ansible :

```sh
sudo apt-get install ansible -y
```

Modifiez le fichier `inventory.ini` selon vos besoins.

---

## Déploiement avec Terraform 🚀

Initialisez et appliquez Terraform pour créer l'infrastructure GCP :

```bash
git clone https://github.com/GamNoise/TP-Terraform-Minecraft.git
cd TP-Terraform-Minecraft/terraform
terraform init
terraform apply
```

Cela créera automatiquement les ressources nécessaires, y compris les machines virtuelles Minecraft pour chaque équipe. 🎮

---

## Configuration avec Ansible ⚡

Une fois la VM déployée, exécutez Ansible pour configurer l'environnement Minecraft :

```sh
ansible-playbook -i inventory.ini playbook-ansible.yml
```

---

## Création d'une Image de l'Instance 📸

Une fois votre VM configurée, créez une image pour faciliter les déploiements futurs :

```sh
gcloud compute images create image-srv-min \
    --source-disk=NOM-DE-LINSTANCE \
    --source-disk-zone=ZONE-DE-LINSTANCE \
    --project=bionic-union-451212-m1
```

Remplacez `NOM-DE-LINSTANCE` et `ZONE-DE-LINSTANCE` par les valeurs correspondantes.

---

## Surveillance et Sauvegarde 📊

- **Monitoring GCP** 📡 : Les VM sont surveillées via Google Cloud Monitoring (CPU, RAM, stockage, et service Minecraft).
- **Sauvegarde Cloud Storage** 💾 : Les données sont sauvegardées régulièrement dans un bucket Cloud Storage pour assurer une récupération en cas de problème.

---

## Gestion de Projet et Versionning 📌

### Suivi du Projet 📋
Le projet est géré et suivi via Trello. Consultez notre tableau pour voir l'état d'avancement des tâches et les prochaines étapes :
[Trello - Micsi 24-3 Minecraft](https://trello.com/b/b6SALYx0/micsi-24-3-minecraft) 🏗️

### Versionning et Dépôt GitHub 🔄
Le projet est hébergé sur GitHub. Retrouvez le code source, suivez les mises à jour et contribuez via :
[GitHub - TP-Terraform-Minecraft](https://github.com/GamNoise/TP-Terraform-Minecraft) 🚀

---

## Améliorations Futures 🔮

- Ajout d'un **reverse proxy / load balancer** pour améliorer la sécurité des accès 🔄
- Automatisation CI/CD pour le **déploiement et la validation** des configurations 🚦
- Amélioration des **règles de firewall** et de la gestion des accès utilisateurs via Ansible et Terraform 🔥

---

Ce projet est un TP Cloud & DevOps permettant de démontrer l'utilisation de Terraform et Ansible pour automatiser le déploiement d'une infrastructure cloud pour un serveur Minecraft. 🎮🚀

---

## Mentions 
### Auteurs
- [Léo Anclin](https://github.com/Castyan)
- [Valentin Halleray](https://github.com/GamNoise)
- [Baptiste Morvilliers](https://github.com/BaptisteMorvilliers)
- [Matéo Demey](https://github.com/Mamat2601)
