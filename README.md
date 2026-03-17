# Terraform + Ansible + AWS + GitHub Actions CI/CD

## Project Overview

This project demonstrates a beginner-to-junior friendly but production-minded DevOps workflow using:

- Terraform for infrastructure provisioning
- Ansible for server configuration
- GitHub Actions for CI/CD automation
- AWS EC2 (Free Tier) for hosting
- Nginx as the web server

The project deploys a static website to an Ubuntu EC2 instance using a release-based deployment strategy:

- `/var/www/myapp/releases/<release-id>`
- `/var/www/myapp/current` -> active release symlink

---

## Architecture

Developer push to GitHub  
→ GitHub Actions CI validates code  
→ GitHub Actions CD connects to EC2 over SSH  
→ uploads a new release  
→ updates the `current` symlink  
→ reloads Nginx  
→ website is updated live

---

## Tools Used

- Terraform
- Ansible
- AWS EC2
- Nginx
- GitHub Actions
- Ubuntu Linux

---

## Terraform Responsibilities

- configure AWS provider
- import local SSH public key to AWS using `aws_key_pair`
- create security group
- allow SSH only from my public IP
- allow HTTP from the internet
- create EC2 instance
- output instance public IP and SSH command

---

## Ansible Responsibilities

- verify SSH connectivity
- install Nginx
- create application directories
- configure Nginx virtual host
- create initial placeholder page
- prepare the server for release-based deployments

---

## GitHub Actions Responsibilities

### CI
- check Terraform formatting
- run Ansible syntax validation

### CD
- generate a release ID
- connect to EC2 over SSH
- upload website files
- create a new release directory
- switch the `current` symlink
- reload Nginx
- run a health check

---

## Deployment Strategy

This project uses a release-based deployment pattern instead of copying files directly into the live web root.

Benefits:

- cleaner deployments
- easier rollback thinking
- more production-like structure
- separation between current release and older releases

---

## AWS Free Tier Safety

This project uses a single EC2 instance to remain within AWS Free Tier.

After completing the project, always destroy infrastructure:

```bash
terraform destroy

Project Structure
.
├── .github/
│   └── workflows/
├── ansible/
│   ├── inventory/
│   ├── playbooks/
│   └── templates/
├── app/
├── terraform/
└── README.md

Learning Outcomes

Infrastructure as Code with Terraform

configuration management with Ansible

CI/CD pipeline basics with GitHub Actions

release directory deployment strategy

Nginx configuration on Ubuntu

SSH-based deployment automation

safe cloud cleanup practices

Important Security Practices

do not commit .terraform/

do not commit terraform.tfstate

do not commit private keys

use GitHub Secrets for deployment secrets

restrict SSH access to a single IP where possible


## Architecture Diagram

### ASCII Architecture

```text
Developer
   |
   | git push
   v
GitHub Repository
   |
   | triggers
   v
GitHub Actions
   |
   |-----------------------------|
   |                             |
   v                             v
CI Workflow                    Deploy Workflow
- terraform fmt -check         - SSH to EC2
- ansible syntax check         - create release directory
                               - upload index.html
                               - switch current symlink
                               - reload nginx
                               - health check
                                     |
                                     v
                              AWS EC2 Ubuntu Server
                              - Nginx installed by Ansible
                              - /var/www/myapp/releases/<release-id>
                              - /var/www/myapp/current -> active release
                                     |
                                     v
                                  Browser



flowchart TD
    A[Developer] -->|git push| B[GitHub Repository]
    B --> C[GitHub Actions CI]
    B --> D[GitHub Actions Deploy]

    C --> C1[Terraform fmt check]
    C --> C2[Ansible syntax check]

    D --> E[AWS EC2 Ubuntu Server]
    E --> E1[Nginx configured by Ansible]
    E --> E2[/var/www/myapp/releases/<release-id>]
    E --> E3[/var/www/myapp/current -> active release]

    D --> F[Create release directory]
    D --> G[Upload website files]
    D --> H[Switch current symlink]
    D --> I[Reload Nginx]
    D --> J[Health check]

    E --> K[Browser]



