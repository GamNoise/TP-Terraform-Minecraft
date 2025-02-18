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

# Clé SSH 
## Générer la paire de clés SSH

```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa_gcp
```

Cela va générer une clé privée `~/.ssh/id_rsa_gcp` et une clé publique `~/.ssh/id_rsa_gcp.pub`.

## Ajouter la clé publique à votre instance GCP

Vous pouvez utiliser `gcloud` pour ajouter la clé publique à votre instance, comme suit :

```bash
gcloud compute instances add-metadata template3 --metadata "ssh-keys=ubuntu:$(cat ~/.ssh/id_rsa_gcp.pub)"
```

Assurez-vous de remplacer `template3` par le nom réel de votre instance GCP.

## Tester la connexion

Ensuite, vous pouvez tester la connexion SSH avec la clé privée générée :

```bash
ssh -i ~/.ssh/id_rsa_gcp ubuntu@34.90.52.100
```
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
