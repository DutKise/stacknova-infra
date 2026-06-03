# StackNova Infra

## Présentation

Ce projet met en œuvre une infrastructure de recette automatisée pour l'application StackNova.

L'objectif est de démontrer l'utilisation conjointe de Terraform et Ansible dans une démarche Infrastructure as Code (IaC).

* Terraform : provisionnement de l'infrastructure
* Ansible : configuration du conteneur
* Docker : exécution du service web Nginx

---

## Arborescence du projet

```text
stacknova-infra/
├── terraform/
│   ├── providers.tf
│   ├── main.tf
│   └── outputs.tf
├── ansible/
│   ├── inventaire.ini
│   └── playbook.yml
├── scripts/
│   └── deploy.sh
├── screens/
└── README.md
```

---

## Prérequis

### Docker

Vérification :

```bash
docker --version
```

Sortie attendue :

```text
Docker version XX.X.X
```

### Terraform

Vérification :

```bash
terraform --version
```

Sortie attendue :

```text
Terraform v1.15.5
```

### Ansible

Vérification :

```bash
ansible --version
```

Sortie attendue :

```text
ansible [core ...]
```

---

## Déploiement

Lancer le déploiement complet :

```bash
bash scripts/deploy.sh
```

Le script réalise automatiquement :

1. Initialisation Terraform
2. Provisionnement du conteneur Docker
3. Exécution du playbook Ansible
4. Déploiement de la page web StackNova

L'application est accessible à l'adresse :

```text
http://localhost:8080
```

---

## Infrastructure Terraform

Terraform utilise le provider Docker Kreuzwerker.

Ressources créées :

* Image Docker nginx:1.27.4
* Conteneur Docker stacknova-recette
* Labels :

  * env=recette
  * project=stacknova

Outputs :

* nom_conteneur
* port_expose

---

## Configuration Ansible

Le playbook réalise les opérations suivantes :

* Vérification du fonctionnement de Nginx
* Déploiement d'une page HTML personnalisée
* Affichage du nom du projet StackNova
* Affichage de l'environnement recette
* Génération dynamique de la date et de l'heure de déploiement

---

## Reproductibilité

La reproductibilité a été vérifiée avec la procédure suivante :

```bash
cd terraform
terraform destroy -auto-approve

cd ..
bash scripts/deploy.sh
```

Le conteneur est recréé automatiquement et la configuration est réappliquée sans intervention manuelle.

---

## Questions théoriques

### Q1. Quelle est la différence entre Terraform et Ansible ? En quoi sont-ils complémentaires dans ce projet ?

Terraform permet de créer et gérer l'infrastructure. Ansible permet de configurer les ressources une fois créées. Dans ce projet, Terraform déploie le conteneur Docker tandis qu'Ansible personnalise son contenu et vérifie son fonctionnement.

### Q2. À quoi sert le state file Terraform ? Quels risques pose sa mauvaise gestion en équipe ?

Le state file conserve l'état de l'infrastructure gérée par Terraform. Sa perte peut entraîner une désynchronisation entre le code et les ressources réelles. En équipe, il doit être partagé via un backend distant afin d'éviter les conflits.

### Q3. Qu'est-ce que l'idempotence ? Donnez un exemple concret tiré de ce projet.

L'idempotence consiste à pouvoir exécuter plusieurs fois une opération sans modifier le résultat final après la première exécution. Relancer le script deploy.sh produit toujours la même infrastructure et la même configuration.

### Q4. Quelle est la différence entre terraform apply et terraform apply -replace ? Dans quel cas utiliseriez-vous le second ?

terraform apply applique les changements nécessaires détectés par Terraform. terraform apply -replace force la recréation d'une ressource spécifique. Cette option est utile lorsqu'une ressource est corrompue ou nécessite une reconstruction complète.

### Q5. Pourquoi est-il déconseillé d'utiliser le tag latest en production ?

Le tag latest n'est pas figé et peut pointer vers différentes versions au fil du temps. Cela nuit à la reproductibilité et rend les déploiements moins prévisibles. Une version explicite garantit un comportement identique à chaque exécution.

```
```
