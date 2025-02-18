# TP-Terraform-Minecraft
TP-CESI-2025 Terraform Ansible pour l'automatisation de la création d'un serveur Minecraft

# faire un WGET sur la vm-template via SSH via GCP console
## Faire un WGET sur la vm-template via SSH via GCP console

Pour télécharger la vm-template, utilisez la commande suivante via SSH dans la console GCP :

```sh
wget "https://github.com/GamNoise/TP-Terraform-Minecraft/blob/main/ansible/playbook-ansible.yml"

wget "https://github.com/GamNoise/TP-Terraform-Minecraft/blob/main/ansible/inventory.ini"

wget "https://github.com/GamNoise/TP-Terraform-Minecraft/blob/main/ansible/ansible.cfg"
```

Remplacez `<URL_DE_LA_VM_TEMPLATE>` par l'URL réelle de la vm-template.
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
