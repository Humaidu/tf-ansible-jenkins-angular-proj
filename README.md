# 🚀 Angular App Deployment with Terraform, Ansible & Jenkins

This project automates the provisioning and deployment of an Angular application on an AWS EC2 instance using **Terraform** (for infrastructure), **Ansible** (for software setup and app deployment), and **Jenkins** (for CI/CD).

---

## 🧱 Tech Stack

- **Frontend**: Angular
- **Provisioning**: Terraform (AWS EC2, Security Groups)
- **Configuration**: Ansible (Jenkins, Nginx, Node.js, Angular CLI)
- **CI/CD**: Jenkins
- **Cloud**: AWS EC2 (Ubuntu 22.04)

---

## 📦 Project Structure

```
angular-devops-project/
├── angular-app/ # Your Angular frontend app
├── terraform/ # Infrastructure setup
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── ansible/ # Configuration management
│ ├── inventory.ini
│ └── playbook.yml
├── jenkins/ # Jenkins pipeline file
│ └── Jenkinsfile
└── README.md

```

---


---

## ✅ Features

- Provision AWS EC2 with open ports for SSH and HTTP
- Install **Node.js**, **Angular CLI**, **Nginx**, and **Jenkins**
- Deploy built Angular app to `/var/www/html/`
- Start Jenkins and Nginx services
- CI/CD-ready setup

---

## ⚙️ Prerequisites

- AWS account and credentials
- Terraform installed
- Ansible installed (on your local/control machine)
- Jenkins (will be installed on EC2)
- SSH key pair (for EC2 access)
- Angular CLI installed locally

## 🚀 Step-by-Step Guide

### 1️⃣ Build Angular App

```bash
cd angular-app
npm install
ng build 

```
This creates the dist/angular-app/ folder for deployment.

---

### 2️⃣ Provision Infrastructure with Terraform

`terraform/main.tf` highlights:
- EC2 instance with Ubuntu 22.04
- Security Group with ports 22, 8080 and 80 open
- SSH key for access

```
cd terraform
terraform init
terraform apply

```
⚠️ Note the public IP of the EC2 instance from Terraform output.

---

### 3️⃣ Update Ansible Inventory

Edit `ansible/inventory.ini`:
```
[web]
<your-ec2-public-ip> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/your-key.pem

```
---

### 4️⃣ Run Ansible Playbook

This installs Jenkins, Node.js, Angular CLI, Nginx, and deploys your app.

```
cd ansible
ansible-playbook -i inventory.ini playbook.yml

```

---

## 5️⃣ Access Your Application

- **Angular App**: `http://<your-ec2-public-ip>`
- **Jenkins**: `http://<your-ec2-public-ip>:8080`

To get the Jenkins unlock password:
```
ssh -i ~/.ssh/your-key.pem ubuntu@<your-ec2-public-ip>
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

```

---

### 6️⃣ CI/CD with Jenkins

In Jenkins:
- Create a new pipeline project
- Use this Jenkinsfile:
  [Jenkinsfile](jenkins/Jenkinsfile)

---

## 🧪 What's Installed via Ansible

| Software       | Purpose              |
| -------------- | -------------------- |
| Node.js        | Needed for Angular   |
| Angular CLI    | To build the app     |
| Nginx          | Serves the built app |
| Jenkins        | CI/CD pipeline       |
| Java (OpenJDK) | Needed for Jenkins   |

---

## 📌 Notes

- Jenkins runs on port 8080
- Angular app served via Nginx on port 80
- Make sure your security group allows both ports