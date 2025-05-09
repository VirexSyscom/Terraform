#!/bin/bash
delay 3000
cd $(System.DefaultWorkingDirectory)
wget https://raw.githubusercontent.com/VirexSyscom/Terraform/refs/heads/main/main.tf
wget https://raw.githubusercontent.com/VirexSyscom/Terraform/refs/heads/main/output.tf
wget https://raw.githubusercontent.com/VirexSyscom/Terraform/refs/heads/main/providers.tf
wget https://raw.githubusercontent.com/VirexSyscom/Terraform/refs/heads/main/ssh.tf
wget https://raw.githubusercontent.com/VirexSyscom/Terraform/refs/heads/main/variables.tf
