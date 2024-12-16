# web_app
#Deploying a dockerised webapp to a kubernetes cluster on AWS EKS

#REQUIREMENTS

#
1. Create a kubernetes using terraform 
2. Create a Web app
3. Dockerise the app
4. Deploy the app to the cluster
5. Deploy an ingress and load balancer
6. View the app on the web

AWS EKS a manges service and thus AWS would handle the control plane setup, upgrades and backups. It also provised the oppurtunity to scale on demand and it works seamlessly with other services like IAM, cloudwatch and ALB and you pay only for what you use.


1) Creating a K8s cluster(AWS EKS) using terraform.
  - Verify terraform installation
  - Verify AWS CLi Installation
  - Install k8s CLI for cluster management
2) 
