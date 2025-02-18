# TP-Terraform-Minecraft
TP-CESI-2025 Terraform Ansible pour l'automatisation de la création d'un serveur Minecraft

# faire un WGET sur la vm-template via SSH via GCP console
## Faire un WGET sur la vm-template via SSH via GCP console

Pour télécharger la vm-template, utilisez la commande suivante via SSH dans la console GCP :

```sh
wget -O playbook-ansible.yml "https://raw.githubusercontent.com/GamNoise/TP-Terraform-Minecraft/refs/heads/main/ansible/playbook-ansible.yml"
chmod +x playbook-ansible.yml  # Rendre le script exécutable

wget "https://raw.githubusercontent.com/GamNoise/TP-Terraform-Minecraft/refs/heads/main/ansible/inventory.ini"
chmod +x inventory.ini

wget "https://raw.githubusercontent.com/GamNoise/TP-Terraform-Minecraft/refs/heads/main/ansible/ansible.cfg"
chmod +x ansible.cfg

sudo apt-get install ansible -y
```
Editer le fichier inventory.ini avec

# Clé SSH 
## Générer la paire de clés SSH
```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa_gcp
gcloud compute instances add-metadata NOM_DE_LINSTANCE --metadata "ssh-keys=ubuntu:$(cat ~/.ssh/id_rsa_gcp.pub)"
```
Remplacer NOM_DE_LINSTANCE par le nom réel de votre instance

# Commande pour jouer le ansible 
```sh
ansible-playbook -i inventory.ini playbook-ansible.yml
```


# Commmande pour faire une image packer 
```sh
gcloud compute images create image-srv-min \
    --source-disk=vm-template \
    --source-disk-zone=europe-west9-b \
    --project=bionic-union-451212-m1
```
