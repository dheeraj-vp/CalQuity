# CalQuity
Tasks Completed

Project Documentation: Supabase Deployment on Azure
1. Introduction
Objective: Deploy a Supabase instance on Azure using a Virtual Machine (VM) and Docker containers.
Technologies Used:
Terraform for Infrastructure as Code (IaC).
Azure VM for running the application.
Docker for containerization of Supabase.
Cloud-init for automated provisioning and configuration.

2. Architecture Overview
Describe the high-level design, including:
The networking setup (VNet, Subnets, NSG).
Security considerations (open ports, user permissions).
VM-based deployment using Docker Compose.
Supabase services deployed in containers (PostgreSQL, Realtime, etc.).

3. Prerequisites
Terraform (installed and configured with Azure credentials).
Azure Subscription.
SSH Keypair for secure VM access.
Supabase Database Password (passed via Terraform variables).
Admin username for VM access.
To access the virtual machine, you'll need an SSH key pair. If you don't have one, follow these steps to generate it:
Generating Your SSH Public Key
On Linux or macOS:
Open a terminal.
Run the following command to generate your SSH key:
bash
CopyEdit
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"


Press Enter to accept the default file location (~/.ssh/id_rsa).
View your public key by running:
bash
CopyEdit
cat ~/.ssh/id_rsa.pub


On Windows (Using Git Bash):
Install Git for Windows if not already installed.
Open Git Bash and run:
bash
CopyEdit
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"


Press Enter to accept the default file location.
View the public key by running:
bash
CopyEdit
cat ~/.ssh/id_rsa.pub


Save the key for future reference

3. Setup Instructions
Clone the Repository:
Clone this project repository to your local machine:
bash
CopyEdit
git clone https://github.com/your-username/your-repo.git


Create the terraform.tfvars File in the Task - 1 Directory and copy the contents of the example-tfvars.tf file into the newly created terraform.tfvars file





4. Deployment Instructions
4.1 Setting Up the Infrastructure
Initialize Terraform:
bash
CopyEdit
terraform init
This initializes the working directory containing the Terraform configuration files.
Plan the Deployment:
bash
CopyEdit
terraform plan
This command generates an execution plan, allowing you to review the resources that will be created, updated, or destroyed.
Apply the Configuration:
bash
CopyEdit
terraform apply
Apply the Terraform plan to provision the resources on Azure.
Retrieve the Public IP:
After the VM is deployed, you can find the public IP of the VM in the Azure portal under the Virtual Machine resource.

4.2 SSH Access to the VM
SSH into the VM:
bash
CopyEdit
ssh -i ~/.ssh/id_rsa azureuser@<public-ip>


Replace <public-ip> with the actual public IP of the VM retrieved from the Azure portal.

4.3 Installing Docker and Docker Compose
Once you're logged into the VM, you need to configure Docker and Docker Compose.
Add the user to the Docker group (to allow the user to run Docker commands without sudo):
bash
CopyEdit
sudo usermod -aG docker azureuser


Apply the new group settings:
bash
CopyEdit
newgrp docker


Verify Docker installation:
bash
CopyEdit
docker ps
This command checks if Docker is running and shows the list of active containers.

4.4 Running Supabase Studio
To deploy Supabase Studio, use the following command:
Run Supabase Studio:
bash
CopyEdit
docker run -d -p 3000:3000 supabase/studio:20250113-83c9420
This will pull the latest Supabase Studio image and run it on port 3000.

4.5 Cloud-init Configuration
The cloud-init script is used to automate the installation and configuration of Docker, Docker Compose, and Supabase on the VM. Below is the cloud-init script (cloud-init.tpl), which gets executed during VM startup.
yaml
CopyEdit
Explanation: This script:
Installs Docker and Docker Compose.
Clones the Supabase repository from GitHub.
Configures the .env file for Supabase, setting the PostgreSQL password.
Runs Supabase in containers using Docker Compose.
4.6 Post-Deployment Verification
Check Docker containers:
bash
CopyEdit
docker ps
Ensure the necessary Supabase containers are running.
Access Supabase Studio:
Open a browser and visit the VM's public IP on port 3000:
cpp
CopyEdit
http://<public-ip>:3000


This will bring up the Supabase Studio interface.

5. Security & Networking
Network Security Groups (NSG):
Ports 22 (SSH), 80 (HTTP), 443 (HTTPS), and 3000 (Supabase Studio) are opened for access.
PostgreSQL (5432) and Supabase Functions (8000-8001) ports are also configured in the NSG.
Ensure that only necessary ports are open, following security best practices.

6.Terraform File Structure Overview:
Briefly list the files in your repository (e.g., main.tf, variables.tf, outputs.tf, cloud-init.tpl, etc.) and explain their purpose.
Example:
Terraform Files:
main.tf: Contains the primary infrastructure configuration.
variables.tf: Defines the variables used in the deployment.
outputs.tf: Exports the public IP and other useful outputs.
cloud-init.tpl: Cloud-init script for automated provisioning on the VM.
Terraform Variables Documentation:
Include a section that explains each variable in detail (what values are expected, any defaults, and where to find examples).
Example:
Variables:
location: The Azure region where resources are deployed.
admin_username: The username for the VM (default: azureuser).
admin_ssh_public_key: Your generated SSH public key.
supabase_db_password: A strong password for the Supabase database.
vm_size: The size of the Azure VM (e.g., Standard_B2s).
resource_group_name: The name of the Azure resource group to use.

7. Conclusion
By following these steps, you've successfully deployed a Supabase instance on Azure using Docker and cloud-init. This setup provides a scalable and automated way to manage Supabase in a cloud environment, leveraging Infrastructure as Code (IaC) for repeatable deployments.


