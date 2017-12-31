# Traditional Two Tier AWS architecture setup example with Terraform
Terraform Example for deploying traditional two tier web application with Web and DB Security Groups.

## What it does:

- Creates VPC with public and private subnet along with Internet Gateway and NAT Gateway.
- Creates Security Groups for Web and Database with ingress and egress rules.
- Deploys two EC2 servers.

## Quick Start:

- Clone the repo.
- Provide Access Key, Secret Key to be used for AWS in `variables.tf`.
- Provide Path to EC2 Key Pair and name of Key Pair in `variables.tf`.
- run `terraform init`
- run `terraform apply`

## TO DO:

- [ ] Add Bootstrap scripts for setting up DB and Web instance.
- [ ] Auto Scaling and load balancer configuration
