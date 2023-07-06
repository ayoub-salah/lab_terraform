**#Scripts Terraform pour l'infrastructure AWS:**

Ce référentiel contient des scripts Terraform pour créer et gérer une infrastructure AWS. Les scripts sont conçus pour automatiser le provisionnement et la configuration des ressources nécessaires pour exécuter une application sur AWS.

**##Configuration:**  
**Avant d'utiliser ces scripts Terraform, assurez-vous d'avoir les éléments suivants :**  
    - Terraform installé localement sur votre machine. Vous pouvez le télécharger à partir de https://www.terraform.io/downloads.html et suivre les instructions d'installation.  
    - Assurez-vous que vos clés d'accès AWS sont configurées dans le fichier provider.tf. Si vous ne les avez pas déjà configurées, ouvrez le fichier provider.tf et remplacez les valeurs suivantes par vos propres         clés d'accès :  

    provider "aws" {
        region     = "us-east-1"
        access_key = "VOTRE_ACCESS_KEY"
        secret_key = "VOTRE_SECRET_KEY"
        }


**##Utilisation:**  
**Une fois que vous avez configuré les variables et que vous êtes prêt à déployer votre infrastructure AWS, suivez les étapes suivantes :**

-Initialisez Terraform en exécutant la commande suivante :  

        $terraform init

-Vérifiez les modifications que Terraform va appliquer en exécutant la commande suivante :  

        $terraform plan

-Déployez votre infrastructure AWS en exécutant la commande suivante :  

        $terraform apply
    
Terraform vous demandera une confirmation avant de procéder au déploiement.  
Attendez que Terraform termine le déploiement. Une fois terminé, il affichera les ressources créées.  

-Pour détruire votre infrastructure AWS, exécutez la commande suivante :  
        $terraform destroy
Terraform vous demandera une confirmation avant de détruire les ressources.

**##Documentation supplémentaire:**  
Pour plus d'informations sur Terraform et comment utiliser ces scripts, veuillez consulter les ressources suivantes :  
    -Documentation Terraform :  https://developer.hashicorp.com/terraform/docs  
    -Guide de démarrage AWS avec Terraform : https://developer.hashicorp.com/terraform/tutorials/aws-get-started  
    -AWS Resource Types Reference : https://registry.terraform.io/providers/hashicorp/aws/latest/docs  
