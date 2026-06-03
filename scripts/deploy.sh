#!/bin/bash
set -e

echo "=== Étape 1 : Création de l'infrastructure avec Terraform ==="

cd terraform
terraform init -upgrade
terraform apply -auto-approve

echo ""
echo "=== Infrastructure créée. Attente de 3 secondes avant configuration... ==="
sleep 3

echo ""
echo "=== Étape 2 : Configuration avec Ansible ==="

cd ../ansible
ansible-playbook -i inventaire.ini playbook.yml

echo ""
echo "=== Déploiement terminé. Accès sur http://localhost:8080 ==="
