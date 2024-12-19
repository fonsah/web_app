EKS Cluster Deployment with Flask Application

This document provides a step-by-step summary of deploying a Flask application on an EKS cluster using Kubernetes and AWS services. The process covers creating the infrastructure, deploying the application, setting up load balancing, and ensuring accessibility over the web. Additionally, it highlights challenges faced during the setup and how they were resolved.

Process Summary

Step 1: Creating an EKS Cluster with Terraform

Objective: Provision an EKS cluster and associated AWS resources using Terraform.

Actions:

VPC Configuration:

Created a VPC with public subnets, an internet gateway, and a route table for public access.

IAM Roles:

Defined IAM roles for the EKS cluster and node groups, attaching required policies for cluster management and worker node operations.

EKS Cluster Creation:

Configured and deployed the EKS cluster with Terraform.

Node Group:

Set up a node group with EC2 instances to serve as Kubernetes worker nodes.

Outcome:
The EKS cluster was successfully created with worker nodes ready to handle Kubernetes workloads.

Step 2: Creating a Flask Application

Objective: Develop a simple Flask application for deployment.

Actions:

Created a main.py file containing a basic Flask application that returns "Hello, Kubernetes!".

Added a requirements.txt file specifying Flask as a dependency.

Outcome:
A functional Flask application was created locally.

Step 3: Dockerizing the Flask Application

Objective: Package the Flask application into a Docker image.

Actions:

Created a Dockerfile with the necessary instructions to containerize the application.

Built the Docker image using:

docker build -t <your-dockerhub-username>/flask-app:latest .

Pushed the image to Docker Hub for external access:

docker push <your-dockerhub-username>/flask-app:latest

Outcome:
The Flask application was successfully containerized and uploaded to Docker Hub.

Step 4: Deploying the Application to Kubernetes

Objective: Deploy the Flask application on the Kubernetes cluster.

Actions:

Created a deployment.yaml file to define the application deployment.

Created a service.yaml file to expose the application using a LoadBalancer service.

Applied the configurations:

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

Verified the deployment using:

kubectl get pods
kubectl get svc

Outcome:
The application was deployed, and a LoadBalancer service exposed it for external access.

Step 5: Deploying an Ingress and Load Balancer

Objective: Set up an Ingress resource with an Application Load Balancer (ALB) to route traffic to the application.

Actions:

Installed the AWS Load Balancer Controller.

Created an ingress.yaml file to define the Ingress resource.

Applied the Ingress configuration:

kubectl apply -f ingress.yaml

Verified the Ingress and ALB setup using:

kubectl get ingress
kubectl describe ingress flask-app-ingress

Outcome:
The Flask application was accessible via the ALB DNS name.

Step 6: Viewing the Application on the Web

Objective: Test the application for public accessibility.

Actions:

Retrieved the ALB DNS name from the Ingress resource:

kubectl get ingress flask-app-ingress

Accessed the application using the ALB DNS name:

curl http://<ALB-DNS-Name>

Outcome:
The application responded with "Hello, Kubernetes! This is my Flask app." ![image of final outcome](web_app/image/flask-app.png)

Challenges and Solutions

1. Docker Push Permission Denied

Error:
Unable to push the Docker image to Docker Hub due to insufficient permissions.

Solution:
Logged into Docker Hub using:

docker login

Successfully authenticated and pushed the image.

2. Worker Nodes Not Ready

Error:
Worker nodes were stuck in NotReady status.

Solution:
Updated the aws-auth ConfigMap to include the IAM role for the node group:

kubectl edit configmap aws-auth -n kube-system

3. Access Denied for Load Balancer Operations

Error:
The ALB Ingress Controller lacked permissions for ELB operations.

Solution:
Created and attached a custom IAM policy to the controller’s IAM role with the required permissions for EC2 and Elastic Load Balancing.

4. Ingress Not Creating ALB

Error:
The ADDRESS field in the Ingress resource remained empty.

Solution:
Ensured the subnets were properly tagged with kubernetes.io/role/elb=1 and verified the controller logs to identify missing permissions.

5. Application Pods Pending

Error:
Pods were stuck in the Pending state due to unsatisfied node taints.

Solution:
Updated node group tolerations to allow scheduling on the worker nodes.